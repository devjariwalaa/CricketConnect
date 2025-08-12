from flask import Flask, request, jsonify
from flask_cors import CORS
import openai
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Configure Ollama with LLaMA 3.2
# Make sure to run: ollama run llama3.2
# The backend will connect to Ollama at http://localhost:11434

@app.route('/ask', methods=['POST'])
def ask_question():
    try:
        data = request.get_json()
        question = data.get('question', '')
        
        if not question:
            return jsonify({'error': 'No question provided'}), 400
        
        # Use Ollama with LLaMA 3.2
        try:
            import requests
            
            # Ollama API endpoint
            ollama_url = "http://localhost:11434/api/generate"
            
            # Prepare the prompt for cricket context
            system_prompt = "You are a helpful cricket assistant. Provide informative and engaging responses about cricket, players, matches, rules, and general cricket knowledge."
            full_prompt = f"{system_prompt}\n\nUser: {question}\n\nAssistant:"
            
            # Request to Ollama
            ollama_data = {
                "model": "llama3.2",
                "prompt": full_prompt,
                "stream": False
            }
            
            ollama_response = requests.post(ollama_url, json=ollama_data, timeout=30)
            
            if ollama_response.status_code == 200:
                response_data = ollama_response.json()
                full_response = response_data.get('response', 'No response from LLaMA')
                
                # Limit response to 150 words
                words = full_response.split()
                if len(words) > 150:
                    response = ' '.join(words[:150]) + '...'
                else:
                    response = full_response
            else:
                response = f"Error: Ollama returned status {ollama_response.status_code}"
                
        except Exception as e:
            response = f"Error calling Ollama: {str(e)}. Make sure Ollama is running with 'ollama run llama3.2'"
        
        return jsonify({'response': response})
    
    except Exception as e:
        return jsonify({'error': f'Server error: {str(e)}'}), 500

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({'status': 'healthy', 'message': 'Flask backend is running'})

if __name__ == '__main__':
    print("Starting Flask backend...")
    print("Make sure your Flutter app is configured to connect to: http://127.0.0.1:5000")
    print("Press Ctrl+C to stop the server")
    
    app.run(host='127.0.0.1', port=5000, debug=True)
