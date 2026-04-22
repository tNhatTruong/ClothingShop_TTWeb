// Slider auto-play (nếu có nhiều slide)
let currentSlide = 0;
const slides = document.querySelectorAll('.hero-slide');

if (slides.length > 1) {
    setInterval(() => {
        slides[currentSlide].classList.remove('active');
        currentSlide = (currentSlide + 1) % slides.length;
        slides[currentSlide].classList.add('active');
    }, 5000);
}