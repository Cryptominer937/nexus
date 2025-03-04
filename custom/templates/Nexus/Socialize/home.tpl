<script type="text/javascript" src="/core/assets/plugins/prism/prism.js"></script>
<script type="text/javascript" src="/core/assets/plugins/tinymce/tinymce.min.js"></script>

{include file='header.tpl'}
{include file='navbar.tpl'}

<div class="ui stackable grid">
  <div class="ui centered row">
    <div class="ui six wide tablet four wide computer column">
      <div class="ui fluid card" id="">
        <div class="content">
          <h4 class="ui header"><i class="fas fa-fire"></i> {$LANG.trending_title}</h4>
          <div class="description">
            <div class="ui list">
              {if $TRENDING == 'Empty'}
              {$LANG.top_rending_undefined}
              {else}
              {foreach from=$TRENDING item=item}
              <div class="item">
                <span class="text">{$item.name}</span>
                <div class="description right floated"><b>{$item.value}</b></div>
              </div>
              {/foreach}
              {/if}
            </div>
          </div>
        </div>
      </div>

      <div class="ui fluid card" id="">
        <div class="content">
          <h4 class="ui header"><i class="fas fa-medal"></i> {$LANG.top_users_title}</h4>
          <div class="description">
            <div class="ui list">
              {foreach from=$TOPUSERS item=item}
                <div class="item">
                  <span class="text">{$item.type}</span>
                  <div class="description right floated">
                    <a href="/profile/{$item.authorUsername}/" data-poload="/queries/user/?id={$item.authorId}" style="{$item.authorStyle}"><b>{$item.authorUsername}</b></a>
                  </div>
                </div>
              {/foreach}
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="ui four wide tablet eight wide computer column" id="socialize_post_list">

      {if $POSTS != null && count($POSTS)}
          {if $USERINFO.userposts.status == 'POST_PUBLISHED'}
            <div class="ui success icon message">
              <i class="check icon"></i>
              <div class="content">
                <div class="header">{$LANG.success_post_published_title}</div>
                  {$LANG.success_post_published_title}
              </div>
            </div>
          {/if}
          <div id="postsSection">
            {foreach from=$POSTS item=item}
            <div class="ui fluid card socialize-post" id="socialize-post-{$item.id}">
              <div class="content">
                <div class="header">
                  <h5 class="ui image header">
                    <img class="ui circular image" src="{$item.authorAvatar}">
                    <div class="content">
                      <a style="font-size:18px;{$item.authorStyle}" href="/profile/{$item.authorUsername}/" data-poload="/queries/user/?id={$item.authorId}">{$item.authorUsername}</a>
                      <div class="sub header" data-toggle="tooltip" data-content="{$item.time}">{$item.timeAgo}</div>
                    </div>
                  </h5>
                </div>

                  <div class="description">
                    <p>{$item.content}</p>
                  </div>
                </div>
              <div class="extra content">
                <div class="sub header" style="justify-content:space-around;display:flex;font-size:16px;">
                  {if $USERINFO.loggeduser.loggedin == 'true'}
                    {if $item.ownPost == true}
                      <a onclick="likePost(this, {$item.id}, {$item.authorId}, 1)" style="cursor: not-allowed;" class="soc-like {if $item.isLiked == true}active{/if} no_selection"><span>{$item.likesCount} <i class="{if $item.isLiked == true}fas {else} far{/if} fa-heart"></i></span></a>
                    {else}
                    <a onclick="likePost(this, {$item.id}, {$item.authorId}, 0)" style="" class="soc-like {if $item.isLiked == true}active{/if} no_selection"><span>{$item.likesCount} <i class="{if $item.isLiked == true}fas {else} far{/if} fa-heart"></i></span></a>
                    {/if}
                  {else}
                    <a onclick="return false;" style="cursor: not-allowed;" class="soc-like no_selection"><span>{$item.likesCount} <i class="{if $item.isLiked == true}fas {else} far{/if} fa-heart"></i></span></a>
                  {/if}
                  <a href="/socialize/post?id={$item.id}" class="soc-comment no_selection"><span>{$item.commentsCount} <i class="far fa-comment"></i></span></a>
                  {if $USERINFO.loggeduser.canDeletePost == 'true' or $item.ownPost == true}
                  <a onclick="return deletePost({if $USERINFO.loggeduser.canDeletePost == 'true'}1{else}0{/if}, {$item.id})" class="soc-comment no_selection"><span><i class="far fa-trash-alt"></i></span></a>
                  {/if}
                </div>
              </div>
            </div>
            {/foreach}
          </div>
          <br />
          {if {$PAGE_LOAD_MORE} == true}
            <a href="/socialize/home?page={$PAGE}" class="ui button blue fluid">Next page</a>
          {/if}

      {else}
        <div class="ui warning icon message">
          <i class="warning icon"></i>
          <div class="content">
            <div class="header">{$LANG.warning_no_posts_found_title}</div>
              {$LANG.warning_no_posts_found_desc}
          </div>
        </div>
      {/if}

    </div>
      <div class="ui six wide tablet four wide computer column">
        <div class="ui fluid card">
          <div class="content">
            <div class="description">
              {if $USERINFO.loggeduser.loggedin == 'false'}
                <center>
                  <p>{$LANG.login_warning}</p>
                  <a class="ui small default button" href="/login/" target="">{$LANG.login_btn}</a>
                  <a class="ui small primary button" href="/register/" target="">{$LANG.register_btn}</a>
                </center>
              {else}
                <center>
                    <img class="ui tiny circular image" src="{$USERINFO.loggeduser.avatar}" style="box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;">
                    <h2 class="ui header" style="margin-top:6px;">
                      <a href="/profile/{$USERINFO.loggeduser.username}/" data-poload="/queries/user/?id={$USERINFO.loggeduser.id}" style="{$USERINFO.loggeduser.style}">{$USERINFO.loggeduser.username}</a>

                    </h2>
                    {if $USERINFO.loggeduser.havePostPerm == true}
                    <div class="new-post-button">
                      <button id="newPostButton" class="ui mini button positive fluid" type="button" name="button" style="" data-toggle="modal" data-target="#newSocializePost"><i class="fas fa-plus"></i> {$LANG.new_post_button}</button>
                    </div>
                    {/if}
                </center>
              {/if}
            </div>
          </div>
        </div>
        {if $USERINFO.loggeduser.loggedin == 'true'}
        <div class="ui fluid card">
          <div class="content">
            <h4 class="ui header"><i class="fas fa-chart-bar"></i> {$LANG.stats_title}</h4>
            <div class="description">
              <div class="ui list">
                  <div class="item">
                    <span class="text"><i class="far fa-paper-plane"></i></span> {$LANG.stats_total_published_posts}</span>
                    <div class="description right floated"><b>{$USERINFO.loggeduser.totalPosts}</b></div>
                  </div>
                <div class="item">
                  <span class="text"><i class="far fa-comment"></i> {$LANG.stats_total_commented_posts}</span>
                  <div class="description right floated"><b>{$USERINFO.loggeduser.totalCommentedPosts}</b></div>
                </div>
                <div class="item">
                  <span class="text"><i class="far fa-heart"></i></span> {$LANG.stats_total_liked_posts}</span>
                  <div class="description right floated"><b>{$USERINFO.loggeduser.totalLikes}</b></div>
                </div>
                <div class="item">
                  <span class="text"><i class="far fa-heart"></i></span> {$LANG.stats_total_received_likes}</span>
                  <div class="description right floated"><b>{$USERINFO.loggeduser.totalReceivedLikes}</b></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        {/if}
      </div>
  </div>
</div>

<div class="ui small modal" id="newSocializePost">
  <div class="header">
     {$LANG.creating_new_post_title}
  </div>
  <div class="content">
    <form class="ui form" action="" method="post" id="newSocializePostForm">
      <div class="field">
        <textarea id="newSocializePostInput" style="resize:none;"rows="6" name="content" placeholder="{$LANG.creating_new_post_placeholder}"></textarea>
      </div>
      <input type="hidden" name="token" id="formtoken" value="{$USERINFO.loggeduser.token}">
      <input type="hidden" name="post" value="1">
      <input type="hidden" name="action" value="newPost">
    </form>
  </div>
  <div class="actions" style="text-align: center;">
    <a class="ui negative button" style="">{$LANG.cancel_btn}</a>
    <button class="ui positive button" type="button" name="button" onclick="submitPost()">{$LANG.post_btn}</button>
  </div>
</div>

{include file='footer.tpl'}
