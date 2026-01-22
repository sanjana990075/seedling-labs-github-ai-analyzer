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
- **AI/LLM:** Google Gemini 1.5 Flash Lite (`models/gemini-flash-lite-latest`) via `google-genai`
- **Testing:** Pytest, HTTPX, Mock
- **DevOps:** GitHub Actions

---

## 🗂️ Project Structure

```text
Seedling_Labs_Github_Analyzer

├── services/
│   ├── github_service.py   # GitHub API interaction logic
│   └── llm_service.py      # Gemini AI integration & prompt engineering
├── .env                    # Stores environment-specific configuration such as API keys.
├── frontend.py             # Streamlit UI application
├── main.py                 # FastAPI backend entry point
├── requirements.txt        # Project dependencies
└── README.md               # Project documentation
```

### 1. Clone & Install

```bash
git clone https://github.com/sanjana990075/seedling-labs-github-ai-analyzer
cd seedling-labs-github-ai-analyzer

# Create virtual environment
python -m venv venv

# Activate virtual environment

# Windows:
venv\Scripts\activate

# macOS / Linux:
source venv/bin/activate

# Install dependencies
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
```

### 3. Run Application
**Backend:**
```bash
uvicorn main:app --reload
```

**Frontend:** (Open a new terminal):
```bash
streamlit run frontend.py
```
*Access UI at http://localhost:8501*

---

---

## 📝 Sample Output

**Input Issue (Example):**
- **Repository URL:** https://github.com/facebook/react
- **Issue Number:** 24502

**Generated Analysis (Sample):**

**Issue Type**  
Bug  

**Priority Score**  
3/5 (3 – Not a functional bug, but a significant unexpected behavior change requiring documentation or clarification.)

**Summary**  
The user is observing that `useEffect` runs twice on component mount in development mode when using React 18 Strict Mode, which is the intended behavior to ensure side effects are idempotent.

**Potential Impact**  
Confusion for developers upgrading to React 18 regarding the lifecycle of `useEffect` in development, potentially leading to unnecessary complexity in handling side effects such as data fetching.

**Suggested Labels**  
- react-18  
- strict-mode  
- documentation  

**📦 Raw JSON Response**
```json
{
  "summary": "The user is observing that `useEffect` runs twice on component mount in development mode when using React 18 Strict Mode, which is the intended behavior to ensure side effects are idempotent.",
  "type": "bug",
  "priority_score": "3 - Not a functional bug, but a significant unexpected behavior change requiring documentation/clarification.",
  "suggested_labels": [
    "react-18",
    "strict-mode",
    "documentation"
  ],
  "potential_impact": "Confusion for developers upgrading to React 18 regarding the lifecycle of `useEffect` in development, potentially leading to unnecessary complexity in handling side effects like data fetching."
}
```

📋 Usability Features

The structured JSON response can be copied directly from the UI

The analysis can also be downloaded as a JSON file for further use (e.g., issue triage, documentation, or automation)

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

---

## ✅ Conclusion

This project demonstrates an end-to-end AI-powered GitHub issue analysis system that combines secure API integration, backend orchestration, and a user-friendly frontend. By aggregating the complete issue context (title, description, and comments) and analyzing it with Google Gemini, the system produces a structured JSON output suitable for immediate triage and decision-making.

Overall, this project showcases practical LLM integration for real-world developer workflows and reflects a production-ready approach to building reliable, secure, and maintainable AI-assisted tooling.

---
