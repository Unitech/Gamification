/*
 * Logo WebLab Jquery plugin v0.3
 * No need of external JS or CSS files
 * Written by Strzelewicz Alexandre
 * http://apps.hemca.com/
 */

(function($) {
    $.fn.WebLabLogo = function(options) {
	var opts = $.extend({}, $.fn.WebLabLogo.defaults, options);
	var o = $.meta ? $.extend({}, opts, $this.data()) : opts;

	o.el = $(this);	

	this.WebLabLogo.construct(o);
	this.WebLabLogo.render(o);
	//this.WebLabLogo.scenarioTwo(o);
	return this.each(function() {
	    $this = $(this);
	});
	
    };

    $.fn.WebLabLogo.defaults = {
	random : false,
	color: '#000000',
	elSize : 50,
	elSpacing : 5,
	expand : false
    };
    
    $.fn.WebLabLogo.scenarioTwo = function(o) {
	var br = '<div id="double-page" style="height : ' + $(window).height() +'px"> </div>';

	console.log(br);

	$('body').append(br);
	setTimeout(function() {
	    $(window).scrollTop($(window).height() + $('#container').height(), 500);
	}, 500);
	    
    };

    $.fn.WebLabLogo.scenarioOne = function(o) {
	o.el.find('#pos-1')
	    .animate({'top' : (o.elSize + o.elSpacing) * 2});
	o.el.find('#pos-7')
	    .animate({'top' : 0}, function() {
		o.el.find('#pos-2')
		    .animate({'top' : (o.elSize + o.elSpacing) * 2});
		o.el.find('#pos-8')
		    .animate({'top' : 0}, function() {
			o.el.find('#pos-3')
			    .animate({'top' : (o.elSize + o.elSpacing) * 2});
			o.el.find('#pos-9')
			    .animate({'top' : 0}, function() {
				o.el.find('#pos-7').fadeOut();
				o.el.find('#pos-3').fadeOut();
				o.el.find('#pos-1').fadeOut();
			    });
		    });
	    });
    };

    $.fn.WebLabLogo.construct = function(o) {
	
	o.elSpacing = o.elSize / 6;
	var logoDOM = 
	    '<div id="internal-logo">' +
	    '<div class="il-el square" id="pos-1">' +
	    '</div>' + 
	    '<div class="il-el square" id="pos-2">' + 
	    '</div>' + 
	    '<div class="il-el square" id="pos-3">' + 
	    '</div>' + 
	    '<div class="il-el square" id="pos-4">' + 
	    '</div>' +
	    '<div class="il-el square" id="pos-5">' +
	    '</div>' + 
	    '<div class="il-el square" id="pos-6">' + 
	    '</div>' +
	    '<div class="il-el square" id="pos-7">' + 
	    '</div>' +
	    '<div class="il-el square" id="pos-8">' +
	    '</div>' +
	    '<div class="il-el circle" id="pos-9">' + 
	    '</div>' + 
	    '</div>';
	//console.log(logoEl);
	o.el.append(logoDOM);	

	
	var logoCSS = 
	    '<style>' +
	    '.square {' +
	    'position : absolute;' +
	    'width : ' + o.elSize + 'px;'+
	    'height : ' + o.elSize + 'px;' +
	    'background-color : #3a3a3a;' +
	    'left : 40px;' +
	    'top : 40px;' +
	    '}  ' +
	    // '#logo:hover {' +
	    // '-moz-transform: rotate(360deg);' +
	    // '-webkit-transform: rotate(360deg);' +
	    // '-o-transform: rotate(360deg);' +
	    // 'transform: rotate(360deg);' +
	    // '}' +
	    '.circle {' + 
	    'position : absolute;' +
	    'width : ' + o.elSize + 'px;'+
	    'height : ' + o.elSize + 'px;' +
	    'background-color : #8bc53e;' +
	    'left : 40px;' +
	    'top : 40px;' +
	    '}' +
	    '</style>';
	o.el.append(logoCSS);

	var tSize = (o.elSize + o.elSpacing) * 3;

	$('#internal-logo', o.el).css({
	    'width' : tSize,
	    'height' : tSize,
	    'position' : 'relative'
	});

	var x = 0, y = 0, i = 0;
	$('.il-el', o.el).delay(200).each(function() {	    
	    if (x == tSize) {
		y += o.elSize + o.elSpacing;
		x = 0;
	    }	    
	    // Expand from center
	    if (o.expand == true) {
		$(this).animate({
	    	    'top' : y,
	    	    'left' : x
		}, 'slow');
		if (i > 7) {
		    o.el.find('.circle').animate({
			'-webkit-border-radius' : o.elSize / 2,
			'-khtml-border-radius' : o.elSize / 2,
			'border-radius' : o.elSize / 2					    
		    });
		}
	    }
	    // No expand
	    else {
		$(this).css({
	    	    'top' : y,
	    	    'left' : x
		}, 'slow');
		if (i > 7) {
		    o.el.find('.circle').css({
			'-webkit-border-radius' : o.elSize / 2,
			'-khtml-border-radius' : o.elSize / 2,
			'border-radius' : o.elSize / 2					    
		    });
		}
	    }
	    i++;
	    x += o.elSize + o.elSpacing;
	});
    };

    $.fn.WebLabLogo.render = function(o) {
	var tmp = $.fn.WebLabLogo.render;
	var i = 0;
	var el = $('#logo');
	var elS = $('.square', el);
	
	function loop() {
	    var tmp = 0;
	    elS.each(function() {
		$(this).animate({'opacity' : i}, 1500, function() {
		    if (tmp == 7) {
			tmp = 0;
			loop();
		    }
		    tmp++;			
		});
		i += 0.1;
		if (i >= 1) {
		    if (o.random == true)
			i = (Math.floor(Math.random()*11) + 1) / 10;
		    else
			i = 0.1;
		}	    
	    });
		
	}
	if (o.expand == true)
	    setTimeout(loop,1200);
	else
	    loop();


	var iswitch = false;

	$(el).click(function() {
	    elS.each(function() {
		var self = $(this); 
		
		if (iswitch == false) {
		    self.animate({
			'-webkit-border-radius' : o.elSize / 2,
			'-khtml-border-radius' : o.elSize / 2,
			'border-radius' : o.elSize / 2			
		    });
		}
		else {
		    // self.animate({
		    // 	'-webkit-border-radius' : 10,
		    // 	'-khtml-border-radius' : 10,
		    // 	'border-radius' : 10
		    // });
		}
	    });
	    iswitch ^= true;
	    el.unbind('click');
	});		      
    };
})(jQuery);
