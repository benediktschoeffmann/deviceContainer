<?php
/**
 * @collector noauto
 */
?>
function Paginator(){
	this.containerClass;
	this.countItems;
	this.countPages;
	this.itemsPerPage;
	this.currentPage;


	this.generatePaginationNav = function(){
		var paginationHtml = '';
		for(i=1;i<=this.countPages;++i){
			if(i==1){
				paginationHtml = paginationHtml + '<div class="paginationButton paginationButtonPrev">&lt;</div><div class="paginationButton paginationButtonActive">' + i + '</div>';
			}else{
				paginationHtml = paginationHtml + '<div class="paginationButton">' + i + '</div>';
			}
		}
		paginationHtml = paginationHtml + '<div class="paginationButton paginationButtonNext">&gt;</div>';
		$('.' + this.containerClass).after('<div class="paginationNav">' + paginationHtml + '</div>');
		var containerClass=this.containerClass;
		var that=this;
		$('.paginationButton').click(function(){
			console.log(that.currentPage);
			if($(this).hasClass('paginationButtonPrev')){
				that.currentPage=$('.' + containerClass).children(':visible').attr('class').replace('entry','').trim().substr($('.' + containerClass).children(':visible').attr('class').replace('entry','').trim().lastIndexOf('-')+1);
				$('.pagination-page-' + that.currentPage).hide();
				if(that.currentPage == 1){
					that.currentPage = that.countPages;
				}else{
					that.currentPage--;
				}
				$('.pagination-page-' + that.currentPage).show();
				$('.paginationButtonActive').removeClass('paginationButtonActive');
				$('.paginationButton:contains("' + that.currentPage + '")').addClass('paginationButtonActive');
			}else if($(this).hasClass('paginationButtonNext')){
				that.currentPage=$('.' + containerClass).children(':visible').attr('class').replace('entry','').trim().substr($('.' + containerClass).children(':visible').attr('class').replace('entry','').trim().lastIndexOf('-')+1);
				$('.pagination-page-' + that.currentPage).hide();
				if(that.currentPage == that.countPages){
					that.currentPage = 1;
				}else{
					that.currentPage++;
				}
				$('.pagination-page-' + that.currentPage).show();
				$('.paginationButtonActive').removeClass('paginationButtonActive');
				$('.paginationButton:contains("' + that.currentPage + '")').addClass('paginationButtonActive');
			}else{
				$('.' + containerClass).children(':visible').hide();
				$('.' + containerClass).children('.pagination-page-' + $(this).text()).show();
				$('.paginationButtonActive').removeClass('paginationButtonActive');
				$(".paginationButton:contains('" + $(this).text() + "')").addClass('paginationButtonActive');
				this.currentPage=$(this).text();
			}

		});
	}
}
Paginator.prototype.setContainerClass = function(value){
	this.containerClass = value;
}
Paginator.prototype.setItemsPerPage = function(value){
	this.itemsPerPage = value;
}
Paginator.prototype.init = function()
{
	this.countItems = $('.' + this.containerClass).children().length;
	this.countPages = Math.ceil(this.countItems/this.itemsPerPage);
	var currentPage=1;
	var itemsPerPage=this.itemsPerPage;
	var countPerPage=0;
	$('.' + this.containerClass).children().each(function(index) {
		if(countPerPage == itemsPerPage){
			currentPage++;
			countPerPage=0;
		}
		$(this).addClass('pagination-page-'+ currentPage);
		countPerPage++;
	});
	$('.' + this.containerClass).children().not('.pagination-page-1').hide();
	this.generatePaginationNav();
	this.currentPage=1;
}
