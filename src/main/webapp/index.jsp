<!DOCTYPE html>
<html>


<head>
   <!--Telling console to download DaisyUI(formatting) and CSS-->
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
           color: #fff;
           /* Set title color to white */
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
           background: linear-gradient(to bottom right, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.3));
           z-index: 1;
       }


       /* Adjust text color for better contrast */
       .text-primary-content {
           color: #fff;
           /* Set text color to white */
       }


       .bg-primary {
           background-color: rgba(0, 0, 0, 0.5);
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
           color: #fff;
           background: linear-gradient(90deg, rgba(255, 0, 150, 1) 0%, rgba(0, 204, 255, 1) 100%);
           z-index: 2;
       }


       .btn-animated:hover {
           background: #fff;
           color: #000;
           border-radius: 5px;
           box-shadow: 0 0 5px #fff, 0 0 25px #fff, 0 0 50px #fff, 0 0 100px #fff;
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
           color: #fff;
       }
   </style>
</head>


<body class="flex flex-col justify-center items-center h-screen w-full relative">
   <div class="flex flex-col justify-center items-center space-y-4 z-10">
       <!--Title: Automated Grading API-->
       <h1 class="text-6xl font-bold typing-effect file-input-primary shadow-custom"
           style="font-family: 'Sofia', Times, serif, sans-serif; font-style: italic;">
           Automated Grading API
       </h1>


       <!-- Theme Button -->
       <div class="dropdown mb-8 self-end" style="position: absolute; top: 20px; right: 20px;">
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
               <li><input type="radio" name="theme-dropdown"
                       class="theme-controller btn btn-sm btn-block btn-ghost justify-start" aria-label="Aqua"
                       value="aqua" /></li>
           </ul>
       </div>


       <!--Choose File Button-->
       <form action="MainServlet" method="POST" enctype="multipart/form-data">
        <label class="form-control w-full max-w-xs shadow-custom">
            <div class="label">
                <span class="label-text">Pick a file</span>
            </div>
            <input type="file" name="image" class="file-input file-input-bordered file-input-primary w-full max-w-xs" required />
        </label>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>


       <!--Dropdown Button: Program Instructions -->
       <div class="collapse bg-base-300 w-full max-w-xl hover-effect shadow-custom">
           <input type="checkbox" class="peer" />
           <div
               class="collapse-title bg-primary text-primary-content peer-checked:bg-secondary peer-checked:text-secondary-content">
               <b>Program Instructions</b>
           </div>
           <div
               class="collapse-content bg-primary text-primary-content peer-checked:bg-secondary peer-checked:text-secondary-content">
               <b class="mb-4">1. Starting the Application</b>
               <li>Open your terminal.</li>
               <li>Navigate to the project directory.</li>
               <li>Run the command mvn tomcat7:run to start the server.</li>
               <li>Access the application by visiting http://localhost:8081/ in your web browser.</li>
               <p class="mb-4"></p>
               <b class="mb-4">2. Uploading a File</b>
               <li>On the web page at http://localhost:8081/, locate the file upload section.</li>
               <li>Select the document or clear photo containing the marked paper and upload it.</li>
           </div>
       </div>


       <!--Dropdown Button: Program Overview-->
       <div class="collapse bg-base-300 w-full max-w-xl hover-effect shadow-custom">
           <input type="checkbox" class="peer" />
           <div
               class="collapse-title bg-primary text-primary-content peer-checked:bg-secondary peer-checked:text-secondary-content">
               <b>Program Overview</b>
           </div>
           <div
               class="collapse-content bg-primary text-primary-content peer-checked:bg-secondary peer-checked:text-secondary-content">
               <b>1. File Upload:</b>
               <li>The teacher drops a file at http://localhost:8081/, accessed via the command mvn tomcat7:run.</li>
               <p class="mb-4"></p>
               <b>2. Web Interface:</b>
               <li>The teacher accesses the web interface at http://localhost:8081/, which serves the index.jsp page.
               </li>
               <p class="mb-4"></p>
               <b>3. Processing the File:</b>
               <li>File Submission: The file gets submitted to a servlet.</li>
               <li>OpenAI GPT-4o: The servlet checks that the file is an image and sends it to OpenAI's GPT-4o model.</li>
               <li>Result Interpretation: GPT-4o reads the image and returns the student's name, grade, course code,
                   and topic (e.g., "Gregory Lauder, 98%, SPH3U, Kinematics").</li>
               <p class="mb-4"></p>
               <b>4. Displaying Results:</b>
               <li>Results Page: The servlet sends the results to the results page, which shows them in a table.</li>
               <li>Send Back to Web Interface: The updated table with the student's grades is sent back to the
                   teacher's web pages.</li>
           </div>
       </div>


       <!--Dropdown Button: Program Information-->
       <div class="collapse bg-base-300 w-full max-w-xl hover-effect shadow-custom">
           <input type="checkbox" class="peer" />
           <div
               class="collapse-title bg-primary text-primary-content peer-checked:bg-secondary peer-checked:text-secondary-content">
               <b>Program Information</b>
           </div>
           <div
               class="collapse-content bg-primary text-primary-content peer-checked:bg-secondary peer-checked:text-secondary-content">
               <li><b>Creator: </b> Hakeem Kashif</li>
               <p class="mb-4"></p>
               <li><b>Course Code: </b> ICS3U-03</li>
               <p class="mb-4"></p>
               <li><b>Built: </b> March to June 2024</li>
               <p class="mb-4"></p>
               <li><b>Project Description: </b> This project automates the grading process by accepting scanned grading
                   files, interpreting the grades using OpenAI's GPT-4o model, and displaying the results in a
                   user-friendly web interface.</li>
           </div>
       </div>


       
   </div>
</body>


</html>





