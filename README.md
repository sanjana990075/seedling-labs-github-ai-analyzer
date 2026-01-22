# seedling-labs-github-ai-analyzer

[![Python 3.9+](https://img.shields.io/badge/python-3.9%2B-blue.svg)](https://www.python.org/downloads/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.68.0%2B-009688.svg)](https://fastapi.tiangolo.com/)
[![Streamlit](https://img.shields.io/badge/Streamlit-1.0.0%2B-FF4B4B.svg)](https://streamlit.io/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


**"Agentic Thinking in a Box"**

An AI-powered web application that automates the triage of GitHub issues. It fetches real-time data, processes it with Google Gemini, and delivers structured, actionable insights to help engineering teams move faster.

---

## 🎯 Problem Statement

At fast-moving companies like Seedling Labs, engineering throughput is critical. Manually reading, categorizing, and prioritizing incoming GitHub issues is a bottleneck.

**The Solution:** A specialized AI agent that:
1.  **Reads** the issue context (Title, Body, Comments).
2.  **Reasons** about the problem using Large Language Models (LLMs).
3.  **Outputs** a standardized JSON classification for immediate action.

---

## ✨ Key Features & "Extra Mile" Enhancements


| Feature | Description | Extra Mile Factor 🚀 |
| :--- | :--- | :--- |
| **Smart Fetching** | Retrieves title, body, and *all* comments to give the LLM full context. | Handles 404s, standardizes URLs, and cleans inputs. |
| **Robust AI Core** | Uses **Few-Shot Prompting** in `llm_service.py` to guarantee strict JSON output. | Includes a **Self-Healing Mechanics** (JSON sanitization) if the LLM output is imperfect. |
| **Interactive UI** | Built with Streamlit for a responsive, modern interface. | **Raw JSON Toggle**, **Copy-to-Clipboard** button for developers, and loading states. |
| **Performance** | Asynchronous-ready FastAPI backend. | **Caching**: Minimizes API costs and latency by caching duplicate requests. |
| **Reliability** | Comprehensive Unit Test Suite. | **CI/CD**: GitHub Actions workflow runs tests automatically on every commit. |

---

## 🛠️ Tech Stack

- **Backend:** Python, FastAPI, Pydantic (Type Safety)
- **Frontend:** Streamlit
- **AI/LLM:** Google Gemini 1.5 Flash (via `google-genai`)
- **Testing:** Pytest, HTTPX, Mock
- **DevOps:** GitHub Actions

---

## 🗂️ Project Structure

```text
Seedling_Labs_Github_Analyzer

├── services/
│   ├── github_service.py   # GitHub API interaction logic
│   └── llm_service.py      # Gemini AI integration & prompt engineering
├── tests/
│   ├── test_github_service.py
│   ├── test_llm_service.py
│   └── test_main.py
├── frontend.py             # Streamlit UI application
├── main.py                 # FastAPI backend entry point
├── requirements.txt        # Project dependencies
└── README.md               # Project documentation
```

### 1. Clone & Install
```bash
git clone https://github.com/sanjana990075/Seedling_Labs_Github_Analyzer.git
cd Seedling_Labs_Github_Analyzer

python -m venv venv
# Windows:
venv\Scripts\activate
# Mac/Linux:
source venv/bin/activate

pip install -r requirements.txt
```

### 2. Configure Credentials
```bash
# Create a .env file in the root directory
# A sample configuration is already provided in .env.example for reference

# Open .env.example (located in the root directory),
# copy its contents, and paste them into a new .env file

GOOGLE_API_KEY=your_google_api_key_here   # required
GITHUB_TOKEN=your_github_token_here       # optional


### 3. Run Application
**Backend:**
```bash
uvicorn main:app --reload
```
**Frontend:** (New Terminal)
```bash
streamlit run frontend.py
```
*Access UI at http://localhost:8501*

---

## 📝 Sample Output

**Input Issue:** *React - "Bug: useEffect cleanups are not running"*

**Generated Analysis:**
```json
{
  "summary": "Users are reporting that cleanup functions in useEffect are not triggering correctly in strict mode.",
  "type": "bug",
  "priority_score": "4 - High priority as it affects core component lifecycle behavior",
  "suggested_labels": ["react-core", "hooks", "bug"],
  "potential_impact": "Could cause memory leaks or inconsistent state in applications relying on cleanup logic."
}
```

---

## 📘 API Reference

The backend exposes the following REST endpoints:

### `GET /`
**Description:** Health check to verify the API is running.
- **Response:** `200 OK`
  ```json
  { "message": "GitHub Issue Analyzer API is running..." }
  ```

### `POST /analyze`
**Description:** Analyzes a specific GitHub issue.
- **Request Body:**
  ```json
  {
    "repo_url": "https://github.com/owner/repo",
    "issue_number": 123
  }
  ```
- **Response:** `200 OK`
  ```json
  {
    "summary": "Issue summary...",
    "type": "bug",
    "priority_score": "5 - Critical",
    "suggested_labels": ["bug", "urgent"],
    "potential_impact": "High impact..."
  }
  ```
- **Errors:**
  - `400`: Issue not found or invalid URL.
  - `502`: GitHub API connection error.
  - `500`: Internal server error.

---

## �📊 Assessment Readiness

### 1. Problem Solving & AI Acumen
- **Prompt Engineering**: Utilized `system_instructions` with 2 distinct few-shot examples to enforce the JSON schema.
- **Edge Cases**: Explicitly handles issues with no comments, rate limits, and non-existent repositories.

### 2. Code Quality
- **Structure**: Separation of concerns (`services/` vs `main.py` vs `frontend.py`).
- **Readability**: Code is compliant with PEP 8 and fully typed.
- **Dependency Management**: Clean `requirements.txt`.

### 3. Speed & Efficiency
- **Tooling**: Leveraged `FastAPI` for speed and `Streamlit` for rapid UI development.
- **Optimization**: Used gemini-flash-lite-latest model for the optimal balance of latency and intelligence.

### 4. Communication
- **Git History**: Clear, atomic commits.
- **Documentation**: This README acts as a clear entry point for any developer.

---
