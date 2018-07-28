//function to render the paginator control
EditableGrid.prototype.updatePaginator = function()
			{
				var paginator = $("#paginator").empty();
				var nbPages = this.getPageCount();

				// get interval
				var interval = this.getSlidingPageInterval(20);
				if (interval == null) return;

				// get pages in interval (with links except for the current page)
				var pages = this.getPagesInInterval(interval, function(pageIndex, isCurrent) {
					if (isCurrent) return "" + (pageIndex + 1);
					return $("<a>").css("cursor", "pointer").html(pageIndex + 1).click(function(event) { editableGrid.setPageIndex(parseInt($(this).html()) - 1); });
				});

				// "first" link
				var link = $("<a>").html("<img src='" + image("gofirst.png") + "'/>&nbsp;");
				if (!this.canGoBack()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
				else link.css("cursor", "pointer").click(function(event) { editableGrid.firstPage(); });
				paginator.append(link);

				// "prev" link
				link = $("<a>").html("<img src='" + image("prev.png") + "'/>&nbsp;");
				if (!this.canGoBack()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
				else link.css("cursor", "pointer").click(function(event) { editableGrid.prevPage(); });
				paginator.append(link);

				// pages
				for (p = 0; p < pages.length; p++) paginator.append(pages[p]).append(" | ");

				// "next" link
				link = $("<a>").html("<img src='" + image("next.png") + "'/>&nbsp;");
				if (!this.canGoForward()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
				else link.css("cursor", "pointer").click(function(event) { editableGrid.nextPage(); });
				paginator.append(link);

				// "last" link
				link = $("<a>").html("<img src='" + image("golast.png") + "'/>&nbsp;");
				if (!this.canGoForward()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
				else link.css("cursor", "pointer").click(function(event) { editableGrid.lastPage(); });
				paginator.append(link);
				
			};
			
			
			
			function image(relativePath) {
	return "images/" + relativePath;
};