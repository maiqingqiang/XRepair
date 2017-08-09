jQuery(document).ready(function () {
/*----------------------------------------------------*/
/*	Keyframe animations enable
/*----------------------------------------------------*/

jQuery().waypoint && jQuery("body").imagesLoaded(function () {
        jQuery(".animate_afc, .animate_afl, .animate_afr, .animate_aft, .animate_afb, .animate_wfc, .animate_hfc, .animate_rfc, .animate_rfl, .animate_rfr").waypoint(function () {
            if (!jQuery(this).hasClass("animate_start")) {
                var e = jQuery(this);
                setTimeout(function () {
                    e.addClass("animate_start")
                }, 20)
            }
        }, {
            offset: "85%",
            triggerOnce: !0
        })
    });



/*----------------------------------------------------*/
/*	Flickr Feed
/*----------------------------------------------------*/

$('ul#flickrfeed').jflickrfeed({
		limit: 6,
		qstrings: {
			id: '71865026@N00'
		},
		itemTemplate: '<li>'+
						'<a rel="prettyPhoto[pp_gal]" href="{{image}}">' +
							'<img src="{{image_s}}" alt="{{title}}" />' +
						'</a>' +
					  '</li>'
	}, function(data) {
		$('a[rel^="prettyPhoto"]').prettyPhoto();
	});


	
/*----------------------------------------------------*/
/*	Superfish Mainmenu Section
/*----------------------------------------------------*/
	
    jQuery(function () {
        jQuery('ul.sf-menu').stop().superfish();
    });
	


/*----------------------------------------------------*/
/*	Revolution Slider Nav Arrow Show Hide
/*----------------------------------------------------*/

    jQuery('.fullwidthbanner-container').hover(function () {
        jQuery('.tp-leftarrow').stop().animate({
            "opacity": 1
        }, 'easeIn');
        jQuery('.tp-rightarrow').stop().animate({
            "opacity": 1
        }, 'easeIn');
    }, function () {
        jQuery('.tp-leftarrow').stop().animate({
            "opacity": 0
        }, 'easeIn');
        jQuery('.tp-rightarrow').stop().animate({
            "opacity": 0
        }, 'easeIn');
    }

    );
	
	
	
    jQuery('.slider-wrapper').hover(function () {
        jQuery('.nivo-prevNav').stop().animate({
            "opacity": 1
        }, 'easeIn');
        jQuery('.nivo-nextNav').stop().animate({
            "opacity": 1
        }, 'easeIn');
    }, function () {
        jQuery('.nivo-prevNav').stop().animate({
            "opacity": 0
        }, 'easeIn');
        jQuery('.nivo-nextNav').stop().animate({
            "opacity": 0
        }, 'easeIn');
    }

    );




/*----------------------------------------------------*/
/*	Accordion Section
/*----------------------------------------------------*/

    jQuery('.accordionMod').each(function (index) {
        var thisBox = jQuery(this).children(),
            thisMainIndex = index + 1;
        jQuery(this).attr('id', 'accordion' + thisMainIndex);
        thisBox.each(function (i) {
            var thisIndex = i + 1,
                thisParentIndex = thisMainIndex,
                thisMain = jQuery(this).parent().attr('id'),
                thisTriggers = jQuery(this).find('.accordion-toggle'),
                thisBoxes = jQuery(this).find('.accordion-inner');
            jQuery(this).addClass('panel');
            thisBoxes.wrap('<div id=\"collapseBox' + thisParentIndex + '_' + thisIndex + '\" class=\"panel-collapse collapse\" />');
            thisTriggers.wrap('<div class=\"panel-heading\" />');
            thisTriggers.attr('data-toggle', 'collapse').attr('data-parent', '#' + thisMain).attr('data-target', '#collapseBox' + thisParentIndex + '_' + thisIndex);
        });
        jQuery('.accordion-toggle').prepend('<span class=\"icon\" />');
		jQuery("div.accordion-item:first-child .accordion-toggle").addClass("current");
		jQuery("div.accordion-item:first-child .icon").addClass("iconActive");
		jQuery("div.accordion-item:first-child .panel-collapse").addClass("in");
        jQuery('.accordionMod .accordion-toggle').click(function () {
            if (jQuery(this).parent().parent().find('.panel-collapse').is('.in')) {
                jQuery(this).removeClass('current');
                jQuery(this).find('.icon').removeClass('iconActive');
            } else {
                jQuery(this).addClass('current');
                jQuery(this).find('.icon').addClass('iconActive');
            }
            jQuery(this).parent().parent().siblings().find('.accordion-toggle').removeClass('current');
            jQuery(this).parent().parent().siblings().find('.accordion-toggle > .icon').removeClass('iconActive');
        });
    });
	//高亮导航
	var curr_url = window.location.href;
	$('nav.menu >ul >li >a').each(function(i,n){
		var href = this.href;
		if(href == curr_url){
			$(this).attr('id','current');
		}
	});
});



/*----------------------------------------------------*/
/*	Nivo Slider
/*----------------------------------------------------*/

jQuery(window).load(function() {
    jQuery('#nivoslider').nivoSlider({
        effect: 'random', // Specify sets like: 'fold,fade,sliceDown'
        slices: 15, // For slice animations
        boxCols: 8, // For box animations
        boxRows: 4, // For box animations
        animSpeed: 500, // Slide transition speed
        pauseTime: 5000, // How long each slide will show
        startSlide: 0, // Set starting Slide (0 index)
        directionNav: true, // Next & Prev navigation
        controlNav: false, // 1,2,3... navigation
        controlNavThumbs: false, // Use thumbnails for Control Nav
        pauseOnHover: true, // Stop animation while hovering
        manualAdvance: false, // Force manual transitions
        prevText: '', // Prev directionNav text
        nextText: '', // Next directionNav text
        randomStart: false, // Start on a random slide
        beforeChange: function(){}, // Triggers before a slide transition
        afterChange: function(){}, // Triggers after a slide transition
        slideshowEnd: function(){}, // Triggers after all slides have been shown
        lastSlide: function(){}, // Triggers when last slide is shown
        afterLoad: function(){} // Triggers when slider has loaded
    });
});



/*----------------------------------------------------*/
/*	Revolution Slider Triggering
/*----------------------------------------------------*/


   jQuery(document).ready(function() {
      if (jQuery.fn.cssOriginal!=undefined)
      jQuery.fn.css = jQuery.fn.cssOriginal;
      jQuery('.fullwidthbanner').revolution({
        delay: 9000,
        startwidth: 1170,
        startheight: 470,

        onHoverStop: "on",
        // Stop Banner Timet at Hover on Slide on/off
        thumbWidth: 100,
        // Thumb With and Height and Amount (only if navigation Tyope set to thumb !)
        thumbHeight: 50,
        thumbAmount: 3,

        hideThumbs: 0,
        navigationType: "none",
        // bullet, thumb, none
        navigationArrows: "solo",
        // nexttobullets, solo (old name verticalcentered), none
        navigationStyle: "square",
        // round,square,navbar,round-old,square-old,navbar-old, or any from the list in the docu (choose between 50+ different item), custom

        navigationHAlign: "center",
        // Vertical Align top,center,bottom
        navigationVAlign: "top",
        // Horizontal Align left,center,right
        navigationHOffset: 0,
        navigationVOffset: 20,

        soloArrowLeftHalign: "left",
        soloArrowLeftValign: "center",
        soloArrowLeftHOffset: 0,
        soloArrowLeftVOffset: 0,

        soloArrowRightHalign: "right",
        soloArrowRightValign: "center",
        soloArrowRightHOffset: 0,
        soloArrowRightVOffset: 0,

        touchenabled: "on",
        // Enable Swipe Function : on/off


        stopAtSlide: -1,
        // Stop Timer if Slide "x" has been Reached. If stopAfterLoops set to 0, then it stops already in the first Loop at slide X which defined. -1 means do not stop at any slide. stopAfterLoops has no sinn in this case.
        stopAfterLoops: -1,
        // Stop Timer if All slides has been played "x" times. IT will stop at THe slide which is defined via stopAtSlide:x, if set to -1 slide never stop automatic
        hideCaptionAtLimit: 0,
        // It Defines if a caption should be shown under a Screen Resolution ( Basod on The Width of Browser)
        hideAllCaptionAtLilmit: 0,
        // Hide all The Captions if Width of Browser is less then this value
        hideSliderAtLimit: 0,
        // Hide the whole slider, and stop also functions if Width of Browser is less than this value

        fullWidth: "on",

        shadow: 0 //0 = no Shadow, 1,2,3 = 3 Different Art of Shadows -  (No Shadow in Fullwidth Version !)
    });




});





/*----------------------------------------------------*/
/*	Carousel Section
/*----------------------------------------------------*/

	jQuery('.portfolio-carousel').carousel({interval: false, wrap: false});
	
	
	jQuery('.client-carousel').carousel({interval: false, wrap: false});
	
	jQuery('.testimonials-carousel').carousel({interval: 5000, pause: "hover"});



$(document).ready(function(){
		$("a[rel^='prettyPhoto']").prettyPhoto({
			animation_speed: 'fast', /* fast/slow/normal */
			slideshow: 5000, /* false OR interval time in ms */
			autoplay_slideshow: false, /* true/false */
			opacity: 0.80, /* Value between 0 and 1 */
			show_title: true, /* true/false */
			allow_resize: true, /* Resize the photos bigger than viewport. true/false */
			default_width: 500,
			default_height: 344,
			counter_separator_label: '/', /* The separator for the gallery counter 1 "of" 2 */
			theme: 'pp_default', /* light_rounded / dark_rounded / light_square / dark_square / facebook */
			horizontal_padding: 20, /* The padding on each side of the picture */
			hideflash: false, /* Hides all the flash object on a page, set to TRUE if flash appears over prettyPhoto */
			wmode: 'opaque', /* Set the flash wmode attribute */
			autoplay: true, /* Automatically start videos: True/False */
			modal: false, /* If set to true, only the close button will close the window */
			deeplinking: true, /* Allow prettyPhoto to update the url to enable deeplinking. */
			overlay_gallery: true, /* If set to true, a gallery will overlay the fullscreen image on mouse over */
			keyboard_shortcuts: true, /* Set to false if you open forms inside prettyPhoto */
			changepicturecallback: function(){}, /* Called everytime an item is shown/changed */
			callback: function(){}, /* Called when prettyPhoto is closed */
			ie6_fallback: true,
			markup: '<div class="pp_pic_holder"> \
						<div class="ppt">&nbsp;</div> \
						<div class="pp_top"> \
							<div class="pp_left"></div> \
							<div class="pp_middle"></div> \
							<div class="pp_right"></div> \
						</div> \
						<div class="pp_content_container"> \
							<div class="pp_left"> \
							<div class="pp_right"> \
								<div class="pp_content"> \
									<div class="pp_loaderIcon"></div> \
									<div class="pp_fade"> \
										<a href="#" class="pp_expand" title="Expand the image">Expand</a> \
										<div class="pp_hoverContainer"> \
											<a class="pp_next" href="#">next</a> \
											<a class="pp_previous" href="#">previous</a> \
										</div> \
										<div id="pp_full_res"></div> \
										<div class="pp_details"> \
											<div class="pp_nav"> \
												<a href="#" class="pp_arrow_previous">Previous</a> \
												<p class="currentTextHolder">0/0</p> \
												<a href="#" class="pp_arrow_next">Next</a> \
											</div> \
											<p class="pp_description"></p> \
											{pp_social} \
											<a class="pp_close" href="#">Close</a> \
										</div> \
									</div> \
								</div> \
							</div> \
							</div> \
						</div> \
						<div class="pp_bottom"> \
							<div class="pp_left"></div> \
							<div class="pp_middle"></div> \
							<div class="pp_right"></div> \
						</div> \
					</div> \
					<div class="pp_overlay"></div>',
			gallery_markup: '<div class="pp_gallery"> \
								<a href="#" class="pp_arrow_previous">Previous</a> \
								<div> \
									<ul> \
										{gallery} \
									</ul> \
								</div> \
								<a href="#" class="pp_arrow_next">Next</a> \
							</div>',
			image_markup: '<img id="fullResImage" src="{path}" />',
			flash_markup: '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="{width}" height="{height}"><param name="wmode" value="{wmode}" /><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="{path}" /><embed src="{path}" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="{width}" height="{height}" wmode="{wmode}"></embed></object>',
			quicktime_markup: '<object classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" codebase="http//www.apple.com/qtactivex/qtplugin.cab" height="{height}" width="{width}"><param name="src" value="{path}"><param name="autoplay" value="{autoplay}"><param name="type" value="video/quicktime"><embed src="{path}" height="{height}" width="{width}" autoplay="{autoplay}" type="video/quicktime" pluginspage="http//www.apple.com/quicktime/download/"></embed></object>',
			iframe_markup: '<iframe src ="{path}" width="{width}" height="{height}" frameborder="no"></iframe>',
			inline_markup: '<div class="pp_inline">{content}</div>',
			custom_markup: '',
			social_tools: '', /* html or false to disable */
		});
	});





/*----------------------------------------------------*/
/*	Hover Overlay
/*----------------------------------------------------*/

jQuery(document).ready(function () {
	jQuery('.portfolio-item').hover(function () {
			jQuery(this).find( '.portfolio-item-hover' ).animate({
				"opacity": 0.8
			}, 100, 'easeInOutCubic');
			
			
		}, function () {
			jQuery(this).find( '.portfolio-item-hover' ).animate({
				"opacity": 0
			}, 100, 'easeInOutCubic');
			
	});
	
	
	jQuery('.portfolio-item').hover(function () {
       jQuery(this).find(".fullscreen").stop().animate({'top' : '60%', 'opacity' : 1}, 250, 'easeOutBack');
        
    }, function () {
        jQuery(this).find(".fullscreen").stop().animate({'top' : '65%', 'opacity' : 0}, 150, 'easeOutBack');
        
    });
	jQuery('.gallery').hover(function () {
       jQuery(this).find(".fullscreen").stop().animate({'top' : '40%', 'opacity' : 1}, 250, 'easeOutBack');
        
    }, function () {
        jQuery(this).find(".fullscreen").stop().animate({'top' : '45%', 'opacity' : 0}, 150, 'easeOutBack');
        
    });
	
	jQuery('.blog-showcase ul li').each(function () {
		jQuery(this).on('hover', function () {
			jQuery(this).siblings('li').removeClass('blog-first-el').end().addClass('blog-first-el');
		});
	});
	
	
	jQuery('.blog-showcase-thumb').hover(function () {
        jQuery(this).find( '.post-item-hover' ).animate({
            "opacity": 0.8
        }, 100, 'easeInOutCubic');
        
    }, function () {
        jQuery(this).find( '.post-item-hover' ).animate({
            "opacity": 0
        }, 100, 'easeInOutCubic');
        
    });
	

	
	jQuery('.blog-showcase-thumb').hover(function () {
       jQuery(this).find(".fullscreen").stop().animate({'top' : '57%', 'opacity' : 1}, 250, 'easeOutBack');
        
    }, function () {
        jQuery(this).find(".fullscreen").stop().animate({'top' : '65%', 'opacity' : 0}, 150, 'easeOutBack');
        
    });



/* Post Image overlay */	
	
	jQuery('.post-image').hover(function () {
        jQuery(this).find( '.img-hover' ).animate({
            "opacity": 0.8
        }, 100, 'easeInOutCubic');
		
        
    }, function () {
        jQuery(this).find( '.img-hover' ).animate({
            "opacity": 0
        }, 100, 'easeInOutCubic');
        
    });
	
	
	jQuery('.post-image').hover(function () {
       jQuery(this).find(".fullscreen").stop().animate({'top' : '55%', 'opacity' : 1}, 250, 'easeOutBack');
        
    }, function () {
        jQuery(this).find(".fullscreen").stop().animate({'top' : '65%', 'opacity' : 0}, 150, 'easeOutBack');
        
    });
	

/*Mobile device topnav opener*/
	
	jQuery( ".down-button" ).click(function() {
    jQuery( ".down-button .icon-current" ).toggleClass("fa fa-angle-up fa fa-angle-down");
});



/*----------------------------------------------------*/
/*	Clients section Parallax
/*----------------------------------------------------*/

	jQuery('.client').parallax("50%", 0.1);
	jQuery('.service-reasons').parallax("50%", 0.1);

	jQuery("a[data-rel^='prettyPhoto']").prettyPhoto({overlay_gallery: false});
	
	

/*----------------------------------------------------*/
/*	Tootltip Initialize
/*----------------------------------------------------*/



    jQuery("[data-toggle='tooltip']").tooltip();

});




/*----------------------------------------------------*/
/*	Sticky Menu
/*----------------------------------------------------*/

	jQuery(document).ready(function(){
		jQuery(".main-header").sticky({topSpacing:0});
	});



/*----------------------------------------------------*/
/*	Scroll To Top Section
/*----------------------------------------------------*/
	jQuery(document).ready(function () {
	
		jQuery(window).scroll(function () {
			if (jQuery(this).scrollTop() > 100) {
				jQuery('.scrollup').fadeIn();
			} else {
				jQuery('.scrollup').fadeOut();
			}
		});
	
		jQuery('.scrollup').click(function () {
			jQuery("html, body").animate({
				scrollTop: 0
			}, 600);
			return false;
		});
	
	});
/*----------------------------------------------------*/
/*	Tabs Control Section
/*----------------------------------------------------*/


	jQuery("#horizontal-tabs").tytabs({
		tabinit: "1",
		fadespeed: "fast"
	});
	jQuery("#horizontal-tabs.two").tytabs({
		tabinit: "1",
		prefixtabs: "tab_two",
		prefixcontent: "content_two",
		fadespeed: "fast"
	});
	jQuery("#horizontal-tabs.three").tytabs({
		tabinit: "1",
		prefixtabs: "tab_three",
		prefixcontent: "content_three",
		fadespeed: "fast"
	});
	jQuery("#horizontal-tabs.four").tytabs({
		tabinit: "1",
		prefixtabs: "tab_four",
		prefixcontent: "content_four",
		fadespeed: "fast"
	});
	jQuery("#horizontal-tabs.five").tytabs({
		tabinit: "1",
		prefixtabs: "tab_five",
		prefixcontent: "content_five",
		fadespeed: "fast"
	});
	jQuery("#vertical-tabs").tytabs({
		tabinit: "1",
		prefixtabs: "tab_v",
		prefixcontent: "content_v",
		fadespeed: "fast"
	});
	jQuery("#vertical-tabs.two").tytabs({
		tabinit: "1",
		prefixtabs: "tab_v_two",
		prefixcontent: "content_v_two",
		fadespeed: "fast"
	});
	jQuery("#vertical-tabs.three").tytabs({
		tabinit: "1",
		prefixtabs: "tab_v_three",
		prefixcontent: "content_v_three",
		fadespeed: "fast"
	});
	jQuery("#vertical-tabs.four").tytabs({
		tabinit: "1",
		prefixtabs: "tab_v_four",
		prefixcontent: "content_v_four",
		fadespeed: "fast"
	});
	jQuery("#vertical-tabs.five").tytabs({
		tabinit: "1",
		prefixtabs: "tab_v_five",
		prefixcontent: "content_v_five",
		fadespeed: "fast"
	});
	jQuery(".hideit").click(function () {
		e(this).fadeOut(600)
	});
	jQuery("#toggle-view li h4").click(function () {
		var t = e(this).siblings("div.panel");
		if (t.is(":hidden")) {
			t.slideDown("200");
			e(this).siblings("span").html("-")
		} else {
			t.slideUp("200");
			e(this).siblings("span").html("+")
		}
	});
	
	jQuery(function (jQuery) {
		jQuery("#example").popover();
		jQuery("#example_left").popover({
			placement: 'left'
		});
		jQuery("#example_top").popover({
			placement: 'top'
		});
		jQuery("#example_bottom").popover({
			placement: 'bottom'
		});
	});
	//点赞等
$(function(){
	//事件绑定
	$("body").on("click","a.js-count-btn", function(){
		var $url=this.href,
			$count=$(this).next(".count"),
			count=parseInt($count.text());
		$.post($url,{},function(data){
			if(data.code==1){
				layer.alert(data.msg, {icon: 6}, function(index){
					$count.text(count+1);
					layer.close(index);
				});
			} else {
				layer.alert(data.msg, {icon: 5}, function(index){
					layer.close(index);
				});
			}
		}, "json");
		return false;	 		
	});
});
//收藏
$(function(){
	$("body").on("click","a.js-favorite-btn", function(){
		var $url=this.href,
			id = $(this).data("id"),
			key = $(this).data("key");
		$.post($url,{id:id,key:key},function(data){
			if(data.code==1){
				layer.alert(data.msg, {icon: 6}, function(index){
					layer.close(index);
				});
			} else {
				layer.alert(data.msg, {icon: 5}, function(index){
					layer.close(index);
				});
			}
		}, "json");
		return false;
	});
});
//删除
$(function(){
	$("body").on("click","a.js-delete-btn", function(){
		var $url=this.href;
		layer.confirm('你确定要删除吗？', {icon: 3}, function(index){
			layer.close(index);
			$.get($url, function(data){
				if(data.code==1){
					layer.alert(data.msg, {icon: 6}, function(index){
						layer.close(index);
						window.location.href=data.url;
					});
				} else {
					layer.alert(data.msg, {icon: 5}, function(index){
						layer.close(index);
					});
				}
			}, "json");
		});
		return false;
	});
});
//评论
$(function(){
	$('form.comment-form').ajaxForm({
		beforeSubmit: checkForm, // 此方法主要是提交前执行的方法，根据需要设置
		success: complete, // 这是提交后的方法
		dataType: 'json'
	});
	var $this=$('form.comment-form'),
		$btn=$this.find('button');
	function checkForm(){
		$btn.text($btn.text() + '中...').prop('disabled', true).addClass('disabled');
	}
	function complete(data){
		$btn.removeClass('disabled').text($btn.text().replace('中...', '')).removeProp('disabled').removeClass('disabled');
		if(data.code==1){
			layer.alert(data.msg, {icon: 6}, function(index){
				var $comments=$this.siblings(".comments"),
					comment_tpl=$this.parent().find('.comment-tpl').html(),
					$comment_tpl=$(comment_tpl),
					$comment_postbox=$this.find(".comment-postbox"),
					comment_content=$comment_postbox.val();
				$comment_tpl.attr("data-id",data.id);
				$comment_tpl.find(".comment-content .content").html(comment_content);
				$comments.append($comment_tpl);
				$comment_postbox.val("");
				layer.close(index);
			});
		}else{
			layer.alert(data.msg, {icon: 5}, function(index){
				layer.close(index);
			});
		}
		return false;
	}
});
//回复
function comment_reply(obj){
	$('.comments .comment-reply-submit').hide();
	var $this=$(obj);
	var $comment_form=$this.parents(".comment-area").find(".comment-form");
	var comment_url=$comment_form.attr("action");
	if(!comment_url){
		layer.alert("未登录", {icon: 5}, function(index){
			layer.close(index);
		});
		return;
	}else{
		var $comment_body=$this.parents(".comments > .comment> .comment-body");
		var commentid=$this.parents(".comment").data("id");
		var $comment_reply_submit=$comment_body.find(".comment-reply-submit");
		if($comment_reply_submit.length){
			$comment_reply_submit.show();
		}else{
			var comment_reply_box_tpl=$comment_body.parents(".comment-area").find(".comment-reply-box-tpl").html();
			$comment_reply_submit=$(comment_reply_box_tpl);
			$comment_body.append($comment_reply_submit);
		}
		$comment_reply_submit.find(".textbox").focus();
		$comment_reply_submit.data("replyid",commentid);
	}
}
//取消回复
function comment_cancel(obj){
	$('.comments .comment-reply-submit').hide();
}
function comment_submit(obj){
	var $this=$(obj);
	var $comment_reply_submit=$this.parents(".comment-reply-submit");
	var $reply_textbox=$comment_reply_submit.find(".textbox");
	var reply_content=$reply_textbox.val();
	if(reply_content==''){
		$reply_textbox.focus();
		return;
	}
	var $comment_body=$this.parents(".comments > .comment> .comment-body");
	var comment_tpl=$comment_body.parents(".comment-area").find(".comment-tpl").html();
	var $comment_tpl=$(comment_tpl);
	var replyid=$comment_reply_submit.data('replyid');
	var $comment=$(".comments [data-id='"+replyid+"']");
	var username=$comment.data("username");
	$comment_tpl.find(".comment-content .toname").html("回复 "+username+" ");
	$comment_tpl.find(".comment-content .content").html(reply_content);
	$comment_reply_submit.before($comment_tpl);
	var $comment_form=$this.parents(".comment-area").find(".comment-form");
	var comment_url=$comment_form.attr("action");
	var n_id=$comment_form.find("[name='n_id']").val();
	var uid=$comment.data("uid");
		$.post(comment_url,
		{
			n_id:n_id,
			to_uid:uid,
			parentid:replyid,
			c_content:reply_content
		},function(data){
			if(data.code==1){
				layer.alert(data.msg, {icon: 6}, function(index){
					$comment_tpl.attr("data-id",data.id);
					$reply_textbox.val('');
					layer.close(index);
				});
			}else{
				layer.alert(data.msg, {icon: 5}, function(index){
					$comment_tpl.remove();
					layer.close(index);
				});
			}
		},'json');
		$comment_reply_submit.hide();	
}
//语言切换
$(function(){
	$("body").on("click","a.js-lang-btn", function(){
		var $url=this.href;
		$.get($url, function(data){
			if(data.code==1){
				layer.alert(data.msg, {icon: 6}, function(index){
					layer.close(index);
					window.location.href=data.url;
				});
			} else {
				layer.alert(data.msg, {icon: 5}, function(index){
					layer.close(index);
				});
			}
		}, "json");
		return false;
	});
});
//搜索
$(function(){
	$('.search-ajaxform').ajaxForm({
		success: complete, // 这是提交后的方法
		dataType: 'json'
	});
	function complete(data){
		if(data){
			window.location.href=data.url;
			//document.write(data);
		}else{
			layer.alert(data.msg, {icon: 5}, function(index){
				layer.close(index);
			});
		}
		return false;
	}
});
//带验证码ajaxform提交
$(function(){
	$('.verify-ajax-form').ajaxForm({
		success: complete, // 这是提交后的方法
		dataType: 'json'
	});
	function complete(data){
		if(data.code==1){
			layer.alert(data.msg, {icon: 6}, function(index){
				layer.close(index);
				window.location.href=data.url;
			});
		}else{
			layer.alert(data.msg, {icon: 5}, function(index){
				layer.close(index);
				if(data.msg=="{:lang('verifiy incorrect')}"){
					$('#verify').val("");
				}else{
					$(':input').val("");
				}
			});
			var $verify_img=$('#verify_img');
			var $url=$verify_img.attr("src");
			if($url.indexOf('?')>0){
				$url=$url+'&'+Math.random();
			}else{
				$url=$url+'?'+Math.random();
			}
			$verify_img.attr("src",$url);
		}
		return false;
	}
});
//ajaxform提交
$(function(){
	$('.ajax-form').ajaxForm({
		success: complete, // 这是提交后的方法
		dataType: 'json'
	});
	function complete(data){
		if(data.code==1){
			layer.alert(data.msg, {icon: 6}, function(index){
				layer.close(index);
				window.location.href=data.url;
			});
		}else{
			layer.alert(data.msg, {icon: 5}, function(index){
				layer.close(index);
			});
		}
		return false;
	}
});
//ajax分页
function ajax_page(page) {        
	$.ajax({
		type:"POST",
		data:{page:page},            
		success: function(data,status){
			$("#news_list").html(data);
		}
	});
}