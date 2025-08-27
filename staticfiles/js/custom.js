/*=========================================
* Background Image
* Mobile Menu
* Menu Bar Popup Icon
* Search Icon Popup
* Sidebar Popup
* Banner Slider Three
* Banner Slider
* Item Active Hover
* CounterUp
* Video Popup
* Image Popup
* Portfolio Slider One
* Portfolio Slider One
* Testimonial Slider One
* Brand Slider
* Theme Preloader
* Request Quote
* Circle Progress Bar
* Scroll To Top
* Theme Dark Light
¸ü¶àÏÂÔØ£ºHttp://www.bootstrapmb.com
=========================================*/
(function ($) {
	"use strict"
	///=============  * Background Image  =============\\\
	$("[data-background]").each(function() {
		$(this).css("background-image", "url(" + $(this).attr("data-background") + ")")
	});

	///=============  * Mobile Menu  =============\\\
	document.addEventListener("DOMContentLoaded", function() {
		var mobileMenu = document.getElementById("mobilemenu");
		var mainMenu = document.querySelector(".vertical_menu");
		var clonedMenu = mobileMenu.cloneNode(true);
		mainMenu.appendChild(clonedMenu);
	});
	jQuery(document).ready(function($) {
		$('.vertical_menu ul li.menu-item-has-children').append('<span class="mobile-arrows far fa-plus"></span>');

		$(".vertical_menu .mobile-arrows").click(function() {
			$(this).parent().find('ul:first').slideToggle(300);
			$(this).toggleClass('is-open');
		});
	});

	///=============  * Menu Bar Popup Icon  =============\\\
	$('.menu__bar i').on("click", function() {
		$(this).toggleClass('clicked');
		$('.menu__bar-popup').toggleClass('show');
		$('.menu__bar-popup-overlay').addClass('show');
	});	  
	$('.menu__bar-popup .close').on("click", function() {
		$('.menu__bar i').removeClass('clicked');
		$('.menu__bar-popup').removeClass('show');
		$('.menu__bar-popup-overlay').removeClass('show');
	});

    ///=============  * Search Icon Popup  =============\\\
    $(".header__area-menubar-center-search-icon.open, .header__area-menubar-right-search-icon.open").on("click", function () {
        $(".header__area-menubar-center-search-box, .header__area-menubar-right-search-box")
            .fadeIn()
            .addClass("active");
        }
    );
    $(".header__area-menubar-center-search-box-icon, .header__area-menubar-right-search-box-icon").on("click", function () {
        $(this).fadeIn().removeClass("active");
    });
    $(".header__area-menubar-center-search-box-icon i, .header__area-menubar-right-search-box-icon i").on("click", function () {
        $(".header__area-menubar-center-search-box, .header__area-menubar-right-search-box")
            .fadeOut()
            .removeClass("active");
        }
    );

	///=============  * Sidebar Popup  =============\\\
	$(document).on("click", ".header__area-menubar-right-sidebar-popup-icon", function () {
		$('.header__area-menubar-right-sidebar-popup').addClass('active');
		$('.sidebar-overlay').addClass('show');
	});
	$(document).on("click", ".header__area-menubar-right-sidebar-popup .sidebar-close-btn", function () {
		$('.header__area-menubar-right-sidebar-popup').removeClass('active');
		$('.sidebar-overlay').removeClass('show');
	});

	///=============  * Banner Slider Three  =============\\\
	var banner_three_thumb = new Swiper(".slide_thumb", {
		spaceBetween: 0,
		slidesPerView: 3,
		freeMode: true,
		watchSlidesProgress: true,
		autoplay: {
			delay: 4500,
			reverseDirection: false,
			disableOnInteraction: false,
		}
	});
	let sliderActive2 = '.slide_three';
	let sliderInit2 = new Swiper(sliderActive2, {
		slidesPerView: 1,
		loop: true,
		effect: 'fade',
		autoplay: {
			delay: 4500,
			reverseDirection: false,
			disableOnInteraction: false,
		},
		navigation: {
			nextEl: '.banner_next',
			prevEl: '.banner_prev',
		},
		thumbs: {
			swiper: banner_three_thumb,
		},
	});

	///=============  * Banner Slider  =============\\\
	let sliderActive1 = '.banner-slider';
	let sliderInit1 = new Swiper(sliderActive1, {
		loop: true,
		slidesPerView: 1,
		effect: 'fade',
		autoplay: {
			delay: 5500,
			reverseDirection: false,
			disableOnInteraction: false,
		},
		navigation: {
			nextEl: '.banner_next',
			prevEl: '.banner_prev',
		},
	});
	function animated_swiper(selector, init) {
		let animated = function animated() {
			$(selector + ' [data-animation]').each(function() {
				let anim = $(this).data('animation');
				let delay = $(this).data('delay');
				let duration = $(this).data('duration');
				$(this).removeClass('anim' + anim).addClass(anim + ' animated').css({
					webkitAnimationDelay: delay,
					animationDelay: delay,
					webkitAnimationDuration: duration,
					animationDuration: duration
				}).one('animationend', function() {
					$(this).removeClass(anim + ' animated');
				});
			});
		};
		animated();
		init.on('slideChange', function() {
			$(sliderActive1 + ' [data-animation]').removeClass('animated');
			$(sliderActive2 + ' [data-animation]').removeClass('animated');
		});
		init.on('slideChange', animated);
	}
	animated_swiper(sliderActive1, sliderInit1);
	animated_swiper(sliderActive2, sliderInit2);
	
	///=============  * Item Active Hover  =============\\\
	$(document).on("mouseenter", ".item_hover", function () {
		$(".item_hover").removeClass("active");
		$(this).addClass("active");
	});

	///============= * Item Active Hover  =============\\\
	$(document).on("mouseenter", ".active_hover", function () {
		$(".active_hover").removeClass("active");
		$(this).addClass("active");
	});

	///=============  * CounterUp  =============\\\
	var counter = $('.counter');
	counter.counterUp({
		time: 2500,
		delay: 100
	});

	///=============  * Video Popup  =============\\\
	$('.video-popup').magnificPopup({
		type: 'iframe'
	});

	///=============  * Image Popup  =============\\\
	$('.img-popup').magnificPopup({
		type: 'image',
		gallery: {
			enabled: true
		}
	});

	///=============  * Portfolio Slider One  =============\\\
	$(document).ready(function () {
		var swiper = new Swiper(".portfolio_slider_one", {
			spaceBetween: 25,
			slidesPerView: 3.8,
			centeredSlides: true,
			speed: 2000,
			loop: true,
			autoplay: {
				delay: 4500,
				reverseDirection: false,
				disableOnInteraction: false,
			},
			breakpoints: {
				0: {
					slidesPerView: 1,
				},
				768: {
					slidesPerView: 2,
				},
				992: {
					slidesPerView: 2.6,
				},
				1200: {
					slidesPerView: 3.4,
				},
				1500: {
					slidesPerView: 3.8,
				},
			}
		});
	});

	///=============  * Portfolio Slider One  =============\\\
	$(document).ready(function () {
		var swiper = new Swiper(".portfolio_slider_three", {
			spaceBetween: 0,
			slidesPerView: 4,
			loop: true,
			autoplay: {
				delay: 4000,
				reverseDirection: false,
				disableOnInteraction: false,
			},
			breakpoints: {
				0: {
					slidesPerView: 1,
				},
				768: {
					slidesPerView: 2,
				},
				992: {
					slidesPerView: 3,
				},
				1200: {
					slidesPerView: 4,
				},
			}
		});
	});

    ///=============  * Testimonial Slider One  =============\\\
	$(document).ready(function () {
		var swiper = new Swiper(".testimonial_one_slider", {
			spaceBetween: 25,
			slidesPerView: 2,
			loop: true,
			navigation: {
				nextEl: '.testimonial_next',
				prevEl: '.testimonial_prev',
			},			
			autoplay: {
				delay: 4000,
				reverseDirection: false,
				disableOnInteraction: false,
			},
			pagination: {
				el: ".testimonial-pagination",
				clickable: true,
			},
			breakpoints: {
				0: {
					slidesPerView: 1,
				},
				992: {
					slidesPerView: 2,
				},
			}
		});
	});

    ///=============  * Brand Slider  =============\\\
	$(document).ready(function () {
		var swiper = new Swiper(".brand_slider", {
			slidesPerView: 7,
			speed: 2000,
			loop: true,
			autoplay: {
				delay: 3500,
				reverseDirection: false,
				disableOnInteraction: false,
			},
			breakpoints: {
				0: {
					slidesPerView: 2,
				},
				768: {
					slidesPerView: 3,
				},
				992: {
					slidesPerView: 5,
				},
				1200: {
					slidesPerView: 7,
				},
			}
		});
	});

    ///=============  * Theme Preloader  =============\\\
    $(window).on("load", function () {
        $(".theme-loader").fadeOut(0.0009);
    });
	
	///============= Skill Bar  =============\\\
	if($('.skill__area-item-bar').length) {
		$('.skill__area-item-bar').appear(function() {
			var el = $(this);
			var percent = el.data('width');
			$(el).css('width', percent + '%');
		}, {
			accY: 0
		});
	};

	///=============  * Request Quote  =============\\\
	var swiper = new Swiper(".request__quote-slider", {
		loop: true,
		speed: 1500,
		spaceBetween: 40,
		slidesPerView: 1,
		autoplay: {
			delay: 3500,
			reverseDirection: false,
			disableOnInteraction: false,
		},
		pagination: {
			el: ".swiper-pagination",
			clickable: true,
		},
	});

	///=============  * Circle Progress Bar  =============\\\
	function animateCircleProgressBar(element) {
		const percent = parseInt(element.getAttribute('data-percent'), 10);
		const progressElement = element.querySelector('.circle__progress-item-bar');
		const percentElement = element.querySelector('.circle__progress-item-number');
		let currentPercent = 0;  
		function updateProgress() {
			if (currentPercent != percent) {
				progressElement.style.background = `conic-gradient(var(--progressColor) ${currentPercent * 3.6}deg, var(--barColor) 0deg)`;
				percentElement.textContent = `${currentPercent++}%`;
				requestAnimationFrame(updateProgress);
			}
		}  
		const observer = new IntersectionObserver(entries => {
			entries.forEach(entry => entry.isIntersecting && (observer.disconnect(), updateProgress()));
		});
		observer.observe(element);
	}
	document.querySelectorAll('.circle__progress-item').forEach(animateCircleProgressBar);

    ///=============  * Scroll To Top  =============\\\
	var scrollPath = document.querySelector(".scroll-up path");
	var pathLength = scrollPath.getTotalLength();
	scrollPath.style.transition = scrollPath.style.WebkitTransition = "none";
	scrollPath.style.strokeDasharray = pathLength + " " + pathLength;
	scrollPath.style.strokeDashoffset = pathLength;
	scrollPath.getBoundingClientRect();
	scrollPath.style.transition = scrollPath.style.WebkitTransition = "stroke-dashoffset 10ms linear";
	var updatescroll = function () {
		var scroll = $(window).scrollTop();
		var height = $(document).height() - $(window).height();
		var scroll = pathLength - (scroll * pathLength) / height;
		scrollPath.style.strokeDashoffset = scroll;
	};
	updatescroll();
	$(window).scroll(updatescroll);
	var offset = 50;
	var duration = 950;
	jQuery(window).on("scroll", function () {
		if (jQuery(this).scrollTop() > offset) {
			jQuery(".scroll-up").addClass("active-scroll");
		}
		else {
			jQuery(".scroll-up").removeClass("active-scroll");
		}
	});	
	jQuery(".scroll-up").on("click", function (event) {
	  	event.preventDefault();
	  	jQuery("html, body").animate(
			{ scrollTop: 0, } , duration
		);
	  	return false;
	});
})(jQuery);

///=============  * Theme Dark Light  =============\\\
function darkLight(){
	var setTheme = document.body;
	setTheme.classList.toggle("dark-mode")
	var theme;
	if(setTheme.classList.contains("dark-mode")){
		theme = "dark";
	}else{
		theme = "light";
	}
	localStorage.setItem("PageTheme", JSON.stringify(theme));
}
let getTheme = JSON.parse(localStorage.getItem("PageTheme"));
if(getTheme === "dark"){
	document.body.classList = "dark-mode";
}