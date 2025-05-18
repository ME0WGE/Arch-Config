#!/bin/bash
# Script to create a Vite React project and clean up unnecessary files

set -e

# 1. Ask the user for the project name
read -p "Enter the project name: " project_name

# 2. Create the Vite React project
echo "Creating Vite React project with name: $project_name..."
npm create vite@latest "$project_name" -- --template react
if [ $? -ne 0 ]; then
  echo "Error: Vite project creation failed."
  exit 1
fi

# 3. Move into the project directory
cd "$project_name"

# 4. Clean up App.jsx
echo "Cleaning up App.jsx..."
app_jsx_path="src/App.jsx"
cat > "$app_jsx_path" <<EOF
import "./App.css";

function App() {
  return (
    <>
      {/* Ready to code! */}
      {/* Script written by github.com/ME0WGE */}
    </>
  );
}

export default App;
EOF

# 5. Clean up index.html
echo "Cleaning up index.html..."
index_html_path="index.html"
cat > "$index_html_path" <<EOF
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>$project_name</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOF

# 6. Clean up CSS files
echo "Cleaning up CSS files..."
> src/index.css
> src/App.css

# 7. Remove unnecessary SVG files
echo "Removing unnecessary SVG files..."
[ -f src/assets/react.svg ] && rm src/assets/react.svg
[ -f public/vite.svg ] && rm public/vite.svg

# 8. Clean up README.md
echo "Cleaning up README.md..."
> README.md

# 9. Install dependencies
echo "Installing dependencies..."
npm install
if [ $? -ne 0 ]; then
  echo "Error: Dependency installation failed."
  exit 1
fi

echo "Vite React project '$project_name' created and cleaned successfully!"

# 10. Open the project in VS Code
echo "Opening the project in VS Code..."
code .
if [ $? -ne 0 ]; then
  echo "Error: Failed to open VS Code."
  exit 1
fi

# 11. Print success message
echo "Vite React project '$project_name' is up and running!"
echo "You can start coding in the 'src' directory."
echo "Enjoy writing (not so) clean code!"
echo "Script written with <3 by | <Kamil Baldyga/> | github.com/ME0WGE"

# 12. Ask the user if they want to start the development server
read -p "Do you want to run 'npm run dev' now? (Y/n): " run_dev
if [[ "$run_dev" =~ ^[Yy]$ ]]; then
  echo "Starting the development server..."
  npm run dev &        # Run in background
  sleep 2              # Wait a bit for the server to start
  echo "Opening the project in the default web browser..."
  xdg-open http://localhost:5173
  if [ $? -ne 0 ]; then
    echo "Error: Failed to open the web browser."
    exit 1
  fi
  wait                 # Wait for npm run dev to finish
fi
# 13. End of script