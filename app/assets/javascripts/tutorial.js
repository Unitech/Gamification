var TUTO = {};
var tuto;

TUTO = function(opt) {
    var self = this;

    self.append_to_dom();
    var url = window.location.href.slice(window.location.href.indexOf('#') + 1);

    if (url == 'auto-launch')
	self.continue_tutorial();
    else
	self.intro();
};

TUTO.prototype.append_to_dom = function() {
    var to_dom = '<div id="mask"></div>'+
	'<canvas id="canvas-tuto"></canvas>' +
	'<div id="descr-tutorial">' + 
	'<div id="internal">' +
	'<div id="descr-content">' +
	'&nbsp;' +
	'</div>' +
	'<div id="descr-next">' +
	'Next >' +
	'</div>' +
	'</div>' +
	'</div>';
    $('body').append(to_dom);


    tuto = {
	el : $('#descr-tutorial'),
	content : $('#descr-content', '#descr-tutorial'),
	next : $('#descr-next', '#descr-tutorial'),
	mask : $('#mask'),
	canvas : $('#canvas-tuto'),
	index_step : 1
    };
};

TUTO.prototype.continue_tutorial = function() {
    tuto.mask.show();
    tuto.el.fadeIn();
    this.launch_interactive_tutorial();
};

TUTO.prototype.intro = function() {
    var self = this;
    $('#launch-tuto').click(function() {	
	// Mask page
	tuto.mask.fadeIn(function() {
	    // Intro
	    tuto.el.fadeIn();
	    tuto.content.html('Bienvenue sur le tutoriel !<br/>Cliquez sur next quand vous etes pret !');
	    tuto.next.click(function() {
		$(this).unbind();
		self.launch_interactive_tutorial();
	    });
	});
	$(this).unbind('click');
    });
};


TUTO.prototype.iterate_next = function(el) {
    var self = this;

    el = $('.step-' + tuto.index_step);
    tuto.index_step++;

    // If end hide all
    if (el.length == 0) {
    	self.stop_tutorial();
    	return;
    }
    el.addClass('selected');

    var el_text_descr = (el.attr('tuto-descr') ? el.attr('tuto-descr') : '&nbsp;');
    
    tuto.content.html(el_text_descr);
    self.draw_line(el);

    tuto.next.click(function() {
	$(this).unbind();
	el.removeClass('selected');
	if (self.handle_next_url(el) == false)
	    self.iterate_next();
    });
};

TUTO.prototype.launch_interactive_tutorial = function() {
    tuto.canvas.show();
    this.iterate_next();
};

TUTO.prototype.stop_tutorial = function() {
    tuto.mask.fadeOut();
    tuto.el.fadeOut();
    this.clear_canvas(tuto.canvas);
    tuto.canvas.hide();
};



TUTO.prototype.handle_next_url = function(el) {
    var next_url = el.attr('next-url');
    var self = this;
    if (next_url != undefined) {

	self.clear_canvas(tuto.canvas);
	tuto.content.html("Le tutoriel continue !<br/> Vous allez etre redirige vers une autre page<br/> (cliquez sur next)");
	tuto.next.click(function() {
	    window.location = next_url + '#auto-launch';
	});
	return true;
    }
    return false;
};


TUTO.prototype.clear_canvas = function(canvasJq) {
    var canvasEl = canvasJq[0];
    var ctx = canvasEl.getContext("2d");
    ctx.clearRect(0, 0, canvasEl.width, canvasEl.height);
}


TUTO.prototype.draw_line = function(blkEls) {
    var canvasEl = tuto.canvas[0];

    canvasEl.width=tuto.canvas.width();
    canvasEl.height=tuto.canvas.height();
    var cOffset = tuto.canvas.offset();
    var ctx = canvasEl.getContext("2d");
    ctx.clearRect(0, 0, canvasEl.width, canvasEl.height);
    ctx.beginPath();

    
    var el = blkEls.first();
    var srcOffset= el.offset();
    var srcMidHeight= el.height()/2 + 30;

    var trgOffset = $('#descr-tutorial').offset();
    var trgMidHeight = $('#descr-tutorial').height()/2;

    ctx.lineWidth = 4;
    ctx.lineCap = 'round';
    ctx.strokeStyle = "white"; // line color

    ctx.moveTo(srcOffset.left + 40, srcOffset.top + srcMidHeight);
    ctx.lineTo(trgOffset.left + 3, trgOffset.top +5 );
    
    ctx.stroke();
    ctx.closePath();
}


$().ready(function() {
    var tut = new TUTO();
});
