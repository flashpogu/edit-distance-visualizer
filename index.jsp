<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Distance Visualizer</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        .match { background-color: #bbf7d0 !important; }
        .replace { background-color: #fecaca !important; }
        .insert, .delete { background-color: #bfdbfe !important; }
    </style>
</head>

<body class="bg-gray-100 min-h-screen">
<div class="max-w-5xl mx-auto py-8 px-4">

    <div class="text-center mb-6">
        <h1 class="text-3xl font-bold text-blue-700">Edit Distance (Levenshtein Distance)</h1>
        <p class="text-gray-600">Enter two words to visualize the DP matrix</p>
    </div>

    <div class="bg-white shadow-xl rounded-lg p-6 max-w-2xl mx-auto">
        <form method="get" class="grid grid-cols-2 gap-4">
            <div>
                <label class="font-semibold text-gray-700">Word 1</label>
                <input type="text" name="word1" required
                       class="mt-1 w-full border border-gray-300 rounded-md px-3 py-2"
                       value="<%= request.getParameter("word1") == null ? "" : request.getParameter("word1") %>">
            </div>

            <div>
                <label class="font-semibold text-gray-700">Word 2</label>
                <input type="text" name="word2" required
                       class="mt-1 w-full border border-gray-300 rounded-md px-3 py-2"
                       value="<%= request.getParameter("word2") == null ? "" : request.getParameter("word2") %>">
            </div>

            <div class="col-span-2 text-center mt-2">
                <button class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded shadow">
                    Visualize
                </button>
            </div>
        </form>
    </div>


<%
String word1 = request.getParameter("word1");
String word2 = request.getParameter("word2");

if(word1 != null && word2 != null) {

    int m = word1.length();
    int n = word2.length();
    int[][] dp = new int[m + 1][n + 1];

    for(int i = 0; i <= m; i++) dp[i][n] = m - i;
    for(int j = 0; j <= n; j++) dp[m][j] = n - j;

    for(int i = m - 1; i >= 0; i--) {
        for(int j = n - 1; j >= 0; j--) {
            if(word1.charAt(i) == word2.charAt(j)) {
                dp[i][j] = dp[i + 1][j + 1];
            } else {
                dp[i][j] = 1 + Math.min(dp[i + 1][j],
                           Math.min(dp[i][j + 1], dp[i + 1][j + 1]));
            }
        }
    }
%>

    <div class="text-center mt-8">
        <h2 class="text-2xl font-bold text-green-700">
            Minimum Edit Distance: <%= dp[0][0] %>
        </h2>
    </div>

    <div class="overflow-auto mt-12">
        <table class="border-collapse mx-auto bg-white shadow-2xl rounded-xl text-xl">

            <tr class="bg-gray-800 text-white text-2xl">
                <th class="px-6 py-4"></th>
                <th class="px-6 py-4"></th>
                <% for(int j = 0; j < n; j++) { %>
                    <th class="px-6 py-4"><%= word2.charAt(j) %></th>
                <% } %>
                <th class="px-6 py-4">∅</th>
            </tr>

            <% for(int i = 0; i <= m; i++) { %>
                <tr class="border-b-2 border-gray-300">
                    <th class="px-6 py-4 bg-gray-800 text-white text-2xl font-bold">
                        <%= i < m ? word1.charAt(i) : "∅" %>
                    </th>

                    <% for(int j = 0; j <= n; j++) {
                        String cssClass = "";

                        if(i < m && j < n && word1.charAt(i) == word2.charAt(j)) cssClass = "match";
                        else if(i < m && j < n) cssClass = "replace";
                        else if(i == m && j < n) cssClass = "insert";
                        else if(i < m && j == n) cssClass = "delete";
                    %>

                    <td class="px-6 py-4 border-2 border-gray-400 text-2xl font-bold <%= cssClass %>">
                        <%= dp[i][j] %>
                    </td>

                    <% } %>
                </tr>
            <% } %>
        </table>
    </div>

<% } %>

</div>
</body>
</html>
