from flask import Flask, request, jsonify, send_from_directory
from transformers import pipeline
import os

# Create Flask app and set frontend directory
app = Flask(__name__, static_folder=os.path.abspath("../frontend"), static_url_path="")

# Load GPT-2 model
chatbot = pipeline("text-generation", model="gpt2")

# Serve the frontend HTML
@app.route("/")
def serve_index():
    return send_from_directory(app.static_folder, "index.html")

# POST endpoint for chat requests
@app.route("/chat", methods=["POST"])
def chat():
    prompt = request.json.get("prompt", "")
    response = chatbot(
    prompt,
    max_length=50,
    num_return_sequences=1,
    do_sample=True,
    top_k=50,
    top_p=0.95,
    temperature=0.7
)

    return jsonify(response[0])

# Run the app
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
