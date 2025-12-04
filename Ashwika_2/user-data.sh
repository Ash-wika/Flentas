#!/bin/bash
yum update -y
yum install -y nginx git
mkdir -p /usr/share/nginx/html
cd /tmp
git clone https://github.com/Ash-wika/resume-website.git 2>/dev/null || {
cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Ashwika - Resume</title>
<style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:Arial,sans-serif;background:#0f0f23;color:#fff;padding:2rem}.container{max-width:1200px;margin:0 auto}.header{background:rgba(102,126,234,0.1);padding:2rem;border-radius:20px;margin-bottom:2rem}.name{font-size:2.5rem;background:linear-gradient(135deg,#667eea,#764ba2);-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:0.5rem}.title{font-size:1.2rem;color:#aaa;margin-bottom:1rem}.contact{color:#999;margin:0.5rem 0}.card{background:rgba(255,255,255,0.05);padding:2rem;border-radius:20px;margin-bottom:2rem}.section-title{font-size:1.5rem;margin-bottom:1rem;color:#667eea}ul{list-style:none;padding-left:1rem}li{margin:0.5rem 0;color:#ccc}li::before{content:"▹ ";color:#667eea}.skill{margin:1rem 0}.skill-name{color:#ccc;margin-bottom:0.5rem}.skill-bar{height:8px;background:rgba(255,255,255,0.1);border-radius:10px;overflow:hidden}.skill-progress{height:100%;background:linear-gradient(135deg,#667eea,#764ba2);border-radius:10px}.footer{text-align:center;padding:2rem;color:#666}</style>
</head><body><div class="container">
<div class="header"><h1 class="name">Ashwika</h1><p class="title">Computer Science Student | Full-Stack Developer</p>
<div class="contact">📧 ashwika11111@gmail.com | 📱 +91-7985556099 | 📍 Kanpur, India</div>
<div class="contact">🔗 <a href="https://linkedin.com/in/ashwika-5306b42a7/" style="color:#667eea">LinkedIn</a> | <a href="https://github.com/Ash-wika" style="color:#667eea">GitHub</a></div>
</div>
<div class="card"><h2 class="section-title">Summary</h2><p style="color:#ccc;line-height:1.8">Computer Science undergrad with strong foundations in DSA and OOP. Skilled in full-stack development using React, Node.js, Express, and MongoDB, with experience in ML model development.</p></div>
<div class="card"><h2 class="section-title">Skills</h2>
<div class="skill"><div class="skill-name">Java</div><div class="skill-bar"><div class="skill-progress" style="width:90%"></div></div></div>
<div class="skill"><div class="skill-name">Python</div><div class="skill-bar"><div class="skill-progress" style="width:85%"></div></div></div>
<div class="skill"><div class="skill-name">JavaScript / React.js / Node.js</div><div class="skill-bar"><div class="skill-progress" style="width:85%"></div></div></div>
<div class="skill"><div class="skill-name">MongoDB / MySQL</div><div class="skill-bar"><div class="skill-progress" style="width:80%"></div></div></div>
</div>
<div class="card"><h2 class="section-title">Experience</h2><h3 style="color:#fff">Software Development Intern - Bluestock</h3><p style="color:#999;margin:0.5rem 0">May 2025 - Jun 2025</p><ul><li>Developed responsive financial dashboard in React.js, reducing page load time by 30%</li><li>Integrated RESTful APIs for dynamic data visualization</li></ul></div>
<div class="card"><h2 class="section-title">Projects</h2><h3 style="color:#fff">MindMentor (May 2025)</h3><p style="color:#999">Next.js, Node.js, MongoDB, AI APIs</p><ul><li>AI-powered study companion with personalized planning</li><li>Used Groq and HuggingFace APIs for adaptive recommendations</li></ul><h3 style="color:#fff;margin-top:1.5rem">GSAP Setup (March 2025)</h3><p style="color:#999">JavaScript, GSAP, CSS, HTML</p><ul><li>Developed smooth animations using GSAP</li><li>Boosted user engagement with dynamic transitions</li></ul><h3 style="color:#fff;margin-top:1.5rem">Diabetes Prediction (Aug 2024)</h3><p style="color:#999">Python, sklearn, numpy, pandas</p><ul><li>ML model for early diabetes detection</li><li>Improved accuracy through hyperparameter tuning</li></ul></div>
<div class="card"><h2 class="section-title">Education</h2><h3 style="color:#fff">B.Tech - Computer Science and Engineering</h3><p style="color:#999">Pranveer Singh Institute Of Technology (Dec 2022 - July 2026)</p><p style="color:#ccc">CGPA: 8.3 | Kanpur, India</p><h3 style="color:#fff;margin-top:1.5rem">Senior Secondary - 90.8%</h3><p style="color:#999">Dr. Virendra Swarup Education Centre (2021-2022)</p></div>
<div class="card"><h2 class="section-title">Certifications</h2><ul><li>Data Analytics - Deloitte/Forage (Jun 2025)</li><li>Machine Learning - Coursera (Dec 2024)</li><li>Java (Basic) - HackerRank (Jun 2024)</li><li>Python Fundamentals - Infosys (Nov 2023)</li></ul></div>
<div class="footer">Deployed on AWS EC2 with Nginx | Infrastructure as Code with Terraform</div>
</div></body></html>
EOF
}
systemctl start nginx
systemctl enable nginx
echo "Done at $(date)" > /var/log/user-data-complete.log
