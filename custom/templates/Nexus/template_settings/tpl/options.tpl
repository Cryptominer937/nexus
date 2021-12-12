<!-- Options Content -->
<div class="card mb-3">
	<h3 class="card-header mb-3 text-center">{$OPTIONS_PAGE}</h3>
	<div class="card-body">

		<form action="" method="POST">
			<input type="hidden" name="sel_btn_session" value="options" />

			<div class="input-group">
				<label for="template_about">{$ABOUT_LABEL}</label>
				<input name="about" id="about" type="checkbox" class="js-switch" {if $ABOUT_VALUE eq 1} checked{/if} />
			</div>

			{if $ABOUT_VALUE eq 1}
			<div class="form-group">
				<div class="input-group">
					<input type="text" class="form-control" id="template_about" name="template_about"
						placeholder="{$ABOUT_PLACEHOLDER_LABEL}" value="{$TEMPLATE_ABOUT}">
					<div class="input-group-append">
						<input type="hidden" name="token" value="{$TOKEN}" />
						<button type="submit" class="btn btn-primary"><i class="fas fa-save"></i></button>
					</div>
				</div>
			</div>
			{/if}
			<div class="form-group">
				<input type="hidden" name="token" value="{$TOKEN}">
				<button style="width: 100%;" type="submit" class="btn btn-primary"><i class="fas fa-save"></i>
					{$SUBMIT}</button>
			</div>
		</form>

		<form action="" method="post">
			<div class="form-group">
				<label for="InputABOUTKey">{$ABOUT_KEY}</label>
				<div class="input-group">
					<input type="text" name="about_key" id="InputABOUTKey" class="form-control" readonly
						value="{if $ABOUT_ENABLED}{$ABOUT_KEY_VALUE}{else}{$ENABLE_ABOUT_FOR_URL}{/if}">
					{if $ABOUT_ENABLED}
					<span class="input-group-append"><a onclick="showRegenModal();"
							class="btn btn-info text-white">{$CHANGE}</a></span>
					{/if}
				</div>
			</div>

			<div class="form-group">
				<label for="InputABOUTURL">{$ABOUT_URL}</label>
				<div class="input-group">
					<input type="text" name="about_url" id="InputABOUTURL" class="form-control" readonly
						value="{if $ABOUT_ENABLED}{$ABOUT_URL_VALUE}{else}{$ENABLE_ABOUT_FOR_URL}{/if}">
					{if $ABOUT_ENABLED}
					<span class="input-group-append"><a onclick="copyURL();"
							class="btn btn-info text-white">{$COPY}</a></span>
					{/if}
				</div>
			</div>

			<div class="form-group">
				<label for="enable_about" style="margin-right:10px">{$ENABLE_ABOUT}</label>
				<input type="hidden" name="enable_about" value="0">
				<input id="enable_about" name="enable_about" type="checkbox" class="js-switch" value="1" {if
					$ABOUT_ENABLED eq 1} checked{/if} />
			</div>

			<div class="form-group">
				<input type="hidden" name="token" value="{$TOKEN}">
				<input type="submit" class="btn btn-primary" value="{$SUBMIT}">
			</div>
		</form>

	</div>
</div>