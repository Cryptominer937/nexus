{include file='header.tpl'}
{include file='navbar.tpl'}

<div class="ui stackable grid">
	<div class="ui centered row">

		{if count($WIDGETS_LEFT)}
			<div class="ui six wide tablet four wide computer column">
				{foreach from=$WIDGETS_LEFT item=widget}
					{$widget}
				{/foreach}
			</div>
		{/if}

		<div
			class="ui {if count($WIDGETS_LEFT) && count($WIDGETS_RIGHT) }four wide tablet eight wide computer{elseif count($WIDGETS_LEFT) || count($WIDGETS_RIGHT)}ten wide tablet twelve wide computer{else}sixteen wide{/if} column">

			{if isset($SUCCESS)}
				<div class="ui success icon message">
					<i class="check icon"></i>
					<div class="content">
						{$SUCCESS}
					</div>
				</div>
			{/if}

			{if isset($ERRORS)}
				<div class="ui negative icon message">
					<i class="x icon"></i>
					<div class="content">
						{foreach from=$ERRORS item=error}
							{$error}<br />
						{/foreach}
					</div>
				</div>
			{/if}


			<div class="ui relaxed centered grid">

			<div style="margin-top: 2rem">
				<a class="ui green button{if !isset($SELECT_CATEGORY_ID)} active{/if}" id="cat"
					href="{$ALL_LINK}">{$SHOW_ALL}</a>
				{foreach from=$CATEGORY_LIST item=category}
					<a class="ui green button{if $SELECT_CATEGORY_ID === $category.id} active{/if}" id="cat{$category.id}"
						href="{$category.link}">{$category.name}</a>

				{/foreach}
			</div>

				<div class="ui shape" onclick="slider()">
					<div class="ui sides">
						{$i = 1}
						{foreach from=$CAROUSEL_LIST item=carousel}
							<div class="ui side{if $i === 1} active{/if}">

								<img src="{$carousel.src}" class="ui hunge bordered rounded image" style="margin-top: 2rem" alt="{$carousel.alt}">
								<div>
									<div class="ui center aligned header {$carousel.carousel_head_class}">{$carousel.carousel_head}</div>
									<div class="ui center aligned description {$carousel.carousel_title_class}">{$carousel.carousel_title}
									</div>
								</div>
							</div>
							{$i = 0}
						{/foreach}
					</div>

				</div>
			</div>

			<div class="ui two column centered grid">

				<div class="ui relaxed" style="width: 100%; padding-top: 1rem">
					<div class="row">
					    <div class="ui left floated animated fade button" onclick="sliderBack()">
							<div class="visible content">Back</div>
								<div class="hidden content">
									<i class="arrow left icon"></i>
								</div>
						</div>
						
						<div class="ui right floated animated fade button" onclick="sliderNext()">
							<div class="visible content">Next</div>
								<div class="hidden content">
									<i class="arrow right icon"></i>
								</div>
						</div>
					</div>
				</div>

				<div class="ui four column centered row">
					<div class="ui medium images rounded">
						{$i = 1}
						{foreach from=$IMAGES_LIST item=image}
							<img src="{$image.small_src}" class="image rounded" onclick="imgModal({$i})">

							<div class="ui longer modal {$i}">
								<div class="content">
									<div class="ui fluid image rounded" style="padding-bottom: 0 !important">
										<img src="{$image.src}">
									</div>
								</div>
								<div class="actions">
									<div class="ui left floated animated fade button" style="margin-left: 0 !important; margin-right: 0 !important; margin-bottom: 1rem" onclick="imgModalBack({$i})">
										<div class="visible content">Back</div>
										<div class="hidden content">
											<i class="arrow left icon"></i>
										</div>
									</div>

									<div class="ui right floated animated fade button" style="margin-left: 0 !important; margin-right: 0 !important; margin-bottom: 1rem" onclick="imgModalNext({$i})">
										<div class="visible content">Next</div>
										<div class="hidden content">
											<i class="arrow right icon"></i>
										</div>
									</div>

								</div>
							</div>
							{$i++}
						{/foreach}

					</div>
				</div>
			</div>
			{$PAGINATION}



		</div>





		{if count($WIDGETS_RIGHT)}
			<div class="ui six wide tablet four wide computer column">
				{foreach from=$WIDGETS_RIGHT item=widget}
					{$widget}
				{/foreach}
			</div>
		{/if}
	</div>
</div>

{include file='footer.tpl'}

<script>
	function slider() {
		$('.shape').shape('flip over');
	}

	function sliderNext() {
		$('.shape').shape('flip right');
	}

	function sliderBack() {
		$('.shape').shape('flip left');
	}

	function imgModal(id) {
		$('.ui.longer.modal.' + id)
			.modal('show');
	}

	function imgModalBack(id) {
		id = id - 1;
		$('.ui.longer.modal.' + id)
			.modal('show');
	}

	function imgModalNext(id) {
		id = id + 1;
		$('.ui.longer.modal.' + id)
			.modal('show');
	}
</script>