# Edit Distance Visualizer (Levenshtein Distance)

This is a JSP-based web application that visualizes the Edit Distance Dynamic Programming table between two input words. It shows insert, delete, and replace operations required to transform one string into another.

## 🚀 Features

- Input two words and visualize the edit distance calculation
- Highlights matching, insertion, deletion, and replacement steps
- Clean UI with Tailwind CSS
- Dynamic Programming matrix visualization
- Easy to deploy using Docker + Tomcat

## 🧮 What is Edit Distance?

Edit Distance (Levenshtein Distance) is the minimum number of operations required to convert one string into another:

- **Insert** a character
- **Delete** a character
- **Replace** a character

This project uses a bottom-up DP approach to compute the distance.

---

## ✅ How to Run Locally

### Requirements

- Docker installed ✅

### Run Command

```bash
docker build -t edit-distance-app .
docker run -p 9090:8080 edit-distance-app
