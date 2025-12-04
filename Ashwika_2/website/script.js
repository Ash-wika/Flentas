// Smooth scroll behavior
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Animate skill bars on scroll
const observerOptions = {
    threshold: 0.5,
    rootMargin: '0px 0px -100px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.width = entry.target.getAttribute('style').match(/width:\s*(\d+%)/)[1];
        }
    });
}, observerOptions);

// Observe all skill progress bars
document.querySelectorAll('.skill-progress').forEach(bar => {
    const width = bar.style.width;
    bar.style.width = '0%';
    observer.observe(bar);
    
    // Trigger animation after a short delay
    setTimeout(() => {
        bar.style.width = width;
    }, 100);
});

// Add stagger animation to timeline items
const timelineItems = document.querySelectorAll('.timeline-item');
timelineItems.forEach((item, index) => {
    item.style.animationDelay = `${index * 0.1}s`;
});

// Add parallax effect to gradient orbs
let mouseX = 0;
let mouseY = 0;

document.addEventListener('mousemove', (e) => {
    mouseX = e.clientX / window.innerWidth;
    mouseY = e.clientY / window.innerHeight;
});

function animateOrbs() {
    const orbs = document.querySelectorAll('.gradient-orb');
    orbs.forEach((orb, index) => {
        const speed = (index + 1) * 0.05;
        const x = mouseX * 50 * speed;
        const y = mouseY * 50 * speed;
        orb.style.transform = `translate(${x}px, ${y}px)`;
    });
    requestAnimationFrame(animateOrbs);
}

animateOrbs();

// Add hover effect to cards
const cards = document.querySelectorAll('.card');
cards.forEach(card => {
    card.addEventListener('mouseenter', function() {
        this.style.borderColor = 'rgba(102, 126, 234, 0.3)';
    });
    
    card.addEventListener('mouseleave', function() {
        this.style.borderColor = 'rgba(255, 255, 255, 0.1)';
    });
});

// Typing effect for the title
const titleElement = document.querySelector('.title');
const titleText = titleElement.textContent;
titleElement.textContent = '';
let charIndex = 0;

function typeTitle() {
    if (charIndex < titleText.length) {
        titleElement.textContent += titleText.charAt(charIndex);
        charIndex++;
        setTimeout(typeTitle, 50);
    }
}

// Start typing effect after page load
window.addEventListener('load', () => {
    setTimeout(typeTitle, 500);
});

// Add intersection observer for fade-in animations
const fadeObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, {
    threshold: 0.1
});

// Observe all cards for fade-in effect
cards.forEach(card => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(20px)';
    card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    fadeObserver.observe(card);
});

// Add dynamic gradient to section titles
const sectionTitles = document.querySelectorAll('.section-title');
sectionTitles.forEach(title => {
    title.addEventListener('mouseenter', function() {
        this.style.background = 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)';
        this.style.webkitBackgroundClip = 'text';
        this.style.webkitTextFillColor = 'transparent';
        this.style.backgroundClip = 'text';
    });
    
    title.addEventListener('mouseleave', function() {
        this.style.background = 'none';
        this.style.webkitTextFillColor = 'var(--text-primary)';
    });
});

// Console message for developers
console.log('%c🚀 Resume Website Deployed on AWS EC2 with Nginx', 
    'color: #667eea; font-size: 16px; font-weight: bold;');
console.log('%c📦 Infrastructure as Code with Terraform', 
    'color: #764ba2; font-size: 14px;');
console.log('%c✨ Built with modern web technologies', 
    'color: #4facfe; font-size: 14px;');
