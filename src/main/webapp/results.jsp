<%@ page contentType="text/html;charset=UTF-8" import="com.finalproject.servlet.Html" %>
<!DOCTYPE html>
<html>

<head>
    <!-- Telling console to download DaisyUI (formatting) and CSS -->
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.11.1/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Typing animation */
        @keyframes typing {
            from {
                width: 0;
            }

            to {
                width: 100%;
            }
        }

        @keyframes blink-caret {

            from,
            to {
                border-color: transparent;
            }

            50% {
                border-color: plum;
            }
        }

        @keyframes stop-blink {

            from,
            to {
                border-color: transparent;
            }
        }

        .typing-effect {
            overflow: hidden;
            border-right: .15em solid plum;
            white-space: nowrap;
            margin: 0 auto;
            letter-spacing: .15em;
            animation: typing 3.5s steps(30, end), blink-caret .75s step-end 7;
            animation-fill-mode: forwards;
            color: #ffffff;
            /* Set title color to white */
            text-shadow: 0 0 10px #ffffff, 0 0 20px #ffffff, 0 0 30px #ff00ff, 0 0 40px #ff00ff, 0 0 50px #ff00ff, 0 0 60px #ff00ff, 0 0 70px #ff00ff;
            /* Add text glow effect */
        }

        /* Background image */
        body {
            background-image: url('https://i.pinimg.com/originals/7d/2a/9f/7d2a9fca264faa93561f72b5fc885fec.gif');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            position: relative;
        }

        /* Gradient overlay */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        /* Adjust text color for better contrast */
        .text-primary-content {
            color: #ffffff;
            /* Set text color to white */
            text-shadow: 0 0 10px #ffffff, 0 0 20px #ffffff, 0 0 30px #ff00ff, 0 0 40px #ff00ff, 0 0 50px #ff00ff, 0 0 60px #ff00ff, 0 0 70px #ff00ff;
            /* Add text glow effect */
        }

        .bg-primary {
            background-color: rgba(0, 0, 0, 0.8);
            /* Set background color for dropdown headers with some transparency */
        }

        .btn-animated {
            position: relative;
            display: inline-block;
            padding: 10px 20px;
            font-size: 18px;
            text-transform: uppercase;
            overflow: hidden;
            transition: 0.5s;
            margin: 10px;
            letter-spacing: 4px;
            color: #ffffff;
            background: linear-gradient(90deg, rgba(255, 0, 150, 1) 0%, rgba(0, 204, 255, 1) 100%);
            z-index: 2;
        }

        .btn-animated:hover {
            background: #ffffff;
            color: #000000;
            border-radius: 5px;
            box-shadow: 0 0 5px #ffffff, 0 0 25px #ffffff, 0 0 50px #ffffff, 0 0 100px #ffffff;
        }

        .btn-animated::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: rgba(255, 255, 255, 0.1);
            pointer-events: none;
            transition: 0.5s;
        }

        .btn-animated:hover::before {
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .hover-effect:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transition: background-color 0.3s ease;
        }

        /* Box shadow for elements */
        .shadow-custom {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .label-text {
            color: #ffffff;
        }

        /* Animation for elements */
        .fade-in {
            animation: fadeIn 2s;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }
        .table-auto {
            width: 80%;
            margin: 20px auto;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            border-radius: 8px;
            overflow: hidden;
        }
 
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #dddddd;
        }
 
        th {
            background-color: #f8f8f8;
            color: #333333;
            font-weight: bold;
        }
 
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>

<body class="flex flex-col justify-start items-center h-screen w-full relative">
    <!-- Main Title -->
    <h1 class="text-8xl font-bold text-primary-content file-input-primary shadow-custom mt-12 fade-in"
        style="font-family: 'Sofia', Times, serif, sans-serif; font-style: italic; position: relative; z-index: 2;">
        Results Page
    </h1>

    <!-- Subtitle -->
    <div class="flex-grow flex flex-col justify-center items-center fade-in" style="position: relative; z-index: 2;">
        <%
            Object error = request.getAttribute("error");
            boolean noGrade = Boolean.TRUE.equals(request.getAttribute("noGrade"));
            Object grade = request.getAttribute("grade");
        %>
        <% if (error != null) { %>
            <h2 class="text-4xl font-bold text-white file-input-primary shadow-custom"><%= Html.escape(error) %></h2>
        <% } else if (noGrade) { %>
            <h2 class="text-6xl font-bold text-white file-input-primary shadow-custom"
                style="font-family: 'Sofia', Times, serif, sans-serif; font-style: italic;">No grade was found</h2>
        <% } else if (grade == null) { %>
            <h2 class="text-4xl font-bold text-white file-input-primary shadow-custom">Upload a test on the home page to see results.</h2>
        <% } else { %>
            <h2 class="text-6xl font-bold text-white file-input-primary shadow-custom"
                style="font-family: 'Sofia', Times, serif, sans-serif; font-style: italic;"><%= Html.escape(grade) %></h2>
            <table class="mt-8 shadow-custom">
                <tr><th>Student name</th><td><%= Html.escape(request.getAttribute("name")) %></td></tr>
                <tr><th>Course code</th><td><%= Html.escape(request.getAttribute("courseCode")) %></td></tr>
                <tr><th>Topic</th><td><%= Html.escape(request.getAttribute("topic")) %></td></tr>
            </table>
        <% } %>
        <a href="./" class="btn btn-primary mt-8">Grade another test</a>
    </div>
              
    <!-- Theme Button -->
    <div class="dropdown mb-8 self-end fade-in" style="position: absolute; top: 20px; right: 20px; z-index: 2;">
        <div tabindex="0" role="button" class="btn btn-animated" id="theme-button">
            Theme
            <svg width="12px" height="12px" class="h-2 w-2 fill-current opacity-60 inline-block"
                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2048 2048">
                <path d="M1799 349l242 241-1017 1017L7 590l242-241 775 775 775-775z"></path>
            </svg>
        </div>
        <ul tabindex="0" class="dropdown-content z-[1] p-2 shadow-2xl bg-base-300 rounded-box w-52">
            <li><input type="radio" name="theme-dropdown"
                    class="theme-controller btn btn-sm btn-block btn-ghost justify-start" aria-label="Default"
                    value="default" /></li>
            <li><input type="radio" name="theme-dropdown"
                    class="theme-controller btn btn-sm btn-block btn-ghost justify-start" aria-label="Retro"
                    value="retro" /></li>
            <li><input type="radio" name="theme-dropdown"
                    class="theme-controller btn btn-sm btn-block btn-ghost justify-start" aria-label="Cyberpunk"
                    value="cyberpunk" /></li>
            <li><input type="radio" name="theme-dropdown"
                    class="theme-controller btn btn-sm btn-block btn-ghost justify-start" aria-label="Valentine"
                    value="valentine" /></li>
        </ul>
    </div>
</body>

</html>