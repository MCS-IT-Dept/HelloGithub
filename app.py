from flask import Flask, render_template
from datetime import datetime

app = Flask(__name__)

GITHUB_FACTS = [
    "GitHub was founded in 2008.",
    "Git was created by Linus Torvalds in 2005.",
    "A 'commit' saves a snapshot of your code changes.",
    "A 'repository' (repo) is a folder tracked by Git.",
    "A 'branch' lets you work on code without affecting the main version.",
    "A 'pull request' is how you propose changes to a project.",
    "The 'README.md' file is the welcome page of a repository.",
    "GitHub has over 100 million developers worldwide.",
    "Open source means the code is free for anyone to read and use.",
    "'Forking' a repo makes your own copy of someone else's project.",
]

@app.route("/")
def hello_github():
    # Pick a fun fact based on the current second (changes every second!)
    fact_index = datetime.now().second % len(GITHUB_FACTS)
    fact = GITHUB_FACTS[fact_index]
    return render_template("index.html", fact=fact)

if __name__ == "__main__":
    import os
    debug = os.environ.get("FLASK_ENV") == "development"
    app.run(host="0.0.0.0", port=5000, debug=debug)
