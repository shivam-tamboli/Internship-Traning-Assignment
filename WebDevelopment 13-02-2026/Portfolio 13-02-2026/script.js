// Mobile Menu Toggle
const menuToggle = document.querySelector('.menu-toggle');
const navLinks = document.querySelector('.nav-links');

if (menuToggle) {
    menuToggle.addEventListener('click', () => {
        navLinks.classList.toggle('active');
        
        // Animate hamburger
        const spans = menuToggle.querySelectorAll('span');
        spans[0].style.transform = navLinks.classList.contains('active') 
            ? 'rotate(45deg) translate(5px, 5px)' : '';
        spans[1].style.opacity = navLinks.classList.contains('active') ? '0' : '1';
        spans[2].style.transform = navLinks.classList.contains('active') 
            ? 'rotate(-45deg) translate(5px, -5px)' : '';
    });
}

// Close menu when clicking a link
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', () => {
        navLinks.classList.remove('active');
        const spans = menuToggle.querySelectorAll('span');
        spans[0].style.transform = '';
        spans[1].style.opacity = '1';
        spans[2].style.transform = '';
    });
});

// Smooth scroll for navigation
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
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

// Intersection Observer for animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('animate');
            
            // Trigger skill bar animation
            if (entry.target.classList.contains('skill-item')) {
                const skillProgress = entry.target.querySelector('.skill-progress');
                const skillValue = entry.target.getAttribute('data-skill');
                if (skillProgress && skillValue) {
                    setTimeout(() => {
                        skillProgress.style.width = skillValue + '%';
                    }, 200);
                }
            }
            
            // Trigger counter animation
            if (entry.target.classList.contains('stat-item')) {
                const counter = entry.target.querySelector('.stat-number');
                const target = parseInt(counter.getAttribute('data-count'));
                animateCounter(counter, target);
            }
        }
    });
}, observerOptions);

// Observe skill items
document.querySelectorAll('.skill-item').forEach(item => {
    observer.observe(item);
});

// Observe stat items
document.querySelectorAll('.stat-item').forEach(item => {
    observer.observe(item);
});

// Observe timeline items
document.querySelectorAll('.timeline-item').forEach(item => {
    observer.observe(item);
});

// Counter animation function
function animateCounter(element, target) {
    let current = 0;
    const increment = target / 50;
    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            element.textContent = target + '+';
            clearInterval(timer);
        } else {
            element.textContent = Math.floor(current) + '+';
        }
    }, 30);
}

// Navbar background on scroll
window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.style.background = 'rgba(10, 10, 10, 0.95)';
        navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.3)';
    } else {
        navbar.style.background = 'rgba(10, 10, 10, 0.8)';
        navbar.style.boxShadow = 'none';
    }
});

// Tilt effect for cards
document.querySelectorAll('[data-tilt]').forEach(card => {
    card.addEventListener('mousemove', (e) => {
        const rect = card.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;
        
        const rotateX = (y - centerY) / 10;
        const rotateY = (centerX - x) / 10;
        
        card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale(1.05)`;
    });
    
    card.addEventListener('mouseleave', () => {
        card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) scale(1)';
    });
});

// Form submission (prevent default for demo)
const contactForm = document.getElementById('contactForm');
if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
        e.preventDefault();
        
        // Get form values
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const subject = document.getElementById('subject').value;
        const message = document.getElementById('message').value;
        
        // Show success message (in real scenario, send to server)
        alert(`Thank you ${name}! Your message has been sent. I'll get back to you soon!`);
        
        // Reset form
        contactForm.reset();
    });
}

// Add loading animation on page load
window.addEventListener('load', () => {
    document.body.style.opacity = '0';
    document.body.style.transition = 'opacity 0.5s ease';
    setTimeout(() => {
        document.body.style.opacity = '1';
    }, 100);
});

// Parallax effect for background circles
document.addEventListener('mousemove', (e) => {
    const circles = document.querySelectorAll('.circle');
    const x = e.clientX / window.innerWidth;
    const y = e.clientY / window.innerHeight;
    
    circles.forEach((circle, index) => {
        const speed = (index + 1) * 20;
        circle.style.transform = `translate(${x * speed}px, ${y * speed}px)`;
    });
});

// Typing effect for hero (if on home page)
const typingText = document.querySelector('.typing-container .hero-title');
if (typingText) {
    const text = typingText.innerHTML;
    typingText.innerHTML = '';
    let i = 0;
    
    function typeWriter() {
        if (i < text.length) {
            typingText.innerHTML += text.charAt(i);
            i++;
            setTimeout(typeWriter, 50);
        }
    }
    
    setTimeout(typeWriter, 1000);
}

// Smooth reveal animation for sections
const revealElements = document.querySelectorAll('.section-title, .skill-card, .contact-card, .timeline-item');

const revealObserver = new IntersectionObserver((entries) => {
    entries.forEach((entry, index) => {
        if (entry.isIntersecting) {
            setTimeout(() => {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }, index * 100);
        }
    });
}, { threshold: 0.1 });

revealElements.forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = 'all 0.6s ease';
    revealObserver.observe(el);
});

// Add hover sound effect (optional - commented out)
/*
const hoverSound = new Audio('hover.mp3');
document.querySelectorAll('a, button').forEach(el => {
    el.addEventListener('mouseenter', () => {
        hoverSound.volume = 0.2;
        hoverSound.play().catch(() => {});
    });
});
*/

// Preload images for smoother experience
const images = document.querySelectorAll('img');
images.forEach(img => {
    img.addEventListener('load', () => {
        img.style.opacity = '1';
    });
});

// Lazy loading for better performance
if ('IntersectionObserver' in window) {
    const lazyImages = document.querySelectorAll('img[data-src]');
    
    const imageObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
                imageObserver.unobserve(img);
            }
        });
    });
    
    lazyImages.forEach(img => imageObserver.observe(img));
}

console.log('Portfolio website loaded successfully!');

