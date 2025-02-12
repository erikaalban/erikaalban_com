document.addEventListener('DOMContentLoaded', () => {
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    const body = document.body;
    const links = document.querySelectorAll('.nav-links a');

    // Toggle menu
    hamburger.addEventListener('click', () => {
        hamburger.classList.toggle('active');
        navLinks.classList.toggle('active');
        body.classList.toggle('menu-open');
    });

    // Close menu when clicking a link
    links.forEach(link => {
        link.addEventListener('click', () => {
            hamburger.classList.remove('active');
            navLinks.classList.remove('active');
            body.classList.remove('menu-open');
        });
    });

    // Close menu when clicking outside
    document.addEventListener('click', (e) => {
        if (!hamburger.contains(e.target) &&
            !navLinks.contains(e.target) &&
            navLinks.classList.contains('active')) {
            hamburger.classList.remove('active');
            navLinks.classList.remove('active');
            body.classList.remove('menu-open');
        }
    });
});

const observerOptions = {
    threshold: 0.2
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
        }
    });
}, observerOptions);

document.querySelectorAll('section').forEach(section => {
    section.classList.add('section');
    observer.observe(section);
});

document.querySelectorAll('.scroll-down').forEach(arrow => {
    arrow.addEventListener('click', function(e) {
        e.preventDefault();
        const href = this.getAttribute('href');
        const targetSection = document.querySelector(href);
        
        targetSection.scrollIntoView({
            behavior: 'smooth'
        });
    });
});

window.addEventListener('scroll', () => {
    const arrows = document.querySelectorAll('.scroll-down');
    const bottomArrow = arrows[arrows.length - 1];
    
    if (window.innerHeight + window.scrollY >= document.documentElement.scrollHeight - 100) {
        bottomArrow.style.opacity = '0';
    } else {
        bottomArrow.style.opacity = '0.8';
    }
});
