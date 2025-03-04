<?php
/*
 *	NamelessMC by Samerton | Template by Mubeen
 *	https://github.com/NamelessMC/Nameless/
 *	NamelessMC version 2.0.0-pr12

 *	License: MIT
 *
 *	Nexus Template
 */

class Nexus_Template extends TemplateBase
{
  private $_template;
    
    /** @var Language */
    private $_language;

    /** @var User */
    private $_user;

    /** @var Pages */
    private $_pages;

    public function __construct($cache, $smarty, $language, $user, $pages)
    {
  
      $template = array(
        'name' => 'Nexus',
        'version' => '1.6.0',
        'nl_version' => '2.0.0-pr12',
        'author' => '<a href="https://github.com/GIGABAIT-Official" target="_blank" rel="nofollow noopener">GIGABAIT Official</a>',
      );
  
      $template['path'] = (defined('CONFIG_PATH') ? CONFIG_PATH : '') . '/custom/templates/' . $template['name'] . '/';
  
      parent::__construct($template['name'], $template['version'], $template['nl_version'], $template['author']);
  
      $this->addCSSFiles(array(
        $template['path'] . 'css/fomantic.min.css' => array(),
        $template['path'] . 'css/toastr.min.css' => array(),
        'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css' => array('integrity' => 'sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==', 'crossorigin' => 'anonymous')
      ));
  
      $this->addJSFiles(array(
        $template['path'] . 'js/jquery.min.js' => array(),
        $template['path'] . 'js/jquery.cookie.js' => array(),
        $template['path'] . 'js/fomantic.min.js' => array(),
        $template['path'] . 'js/toastr.min.js' => array(),
      ));
  
      $smarty->assign('TEMPLATE', $template);
  
      // Other variables
      $smarty->assign('FORUM_SPAM_WARNING_TITLE', $language->get('general', 'warning'));
  
      $this->_template = $template;
      $this->_language = $language;
      $this->_user = $user;
      $this->_pages = $pages;
    }
  
    public function onPageLoad()
    {
  
      $this->addCSSFiles(array(
        $this->_template['path'] . 'css/custom.css' => array()
      ));
  
      $route = (isset($_GET['route']) ? rtrim($_GET['route'], '/') : '/');
  
      $JSVariables = array(
        'siteName' => SITE_NAME,
        'siteURL' => URL::build('/'),
        'fullSiteUrl' => Util::getSelfURL() . ltrim(URL::build('/'), '/'),
        'page' => PAGE,
        'avatarSource' => Util::getAvatarSource(),
        'copied' => $this->_language->get('general', 'copied'),
        'cookieNotice' => $this->_language->get('general', 'cookie_notice'),
        'noMessages' => $this->_language->get('user', 'no_messages'),
        'newMessage1' => $this->_language->get('user', '1_new_message'),
        'newMessagesX' => $this->_language->get('user', 'x_new_messages'),
        'noAlerts' => $this->_language->get('user', 'no_alerts'),
        'newAlert1' => $this->_language->get('user', '1_new_alert'),
        'newAlertsX' => $this->_language->get('user', 'x_new_alerts'),
        'bungeeInstance' => $this->_language->get('general', 'bungee_instance'),
        'andMoreX' => $this->_language->get('general', 'and_x_more'),
        'noPlayersOnline' => $this->_language->get('general', 'no_players_online'),
        'offline' => $this->_language->get('general', 'offline'),
        'confirmDelete' => $this->_language->get('general', 'confirm_deletion'),
        'debugging' => ((defined('DEBUGGING') && DEBUGGING == 1) ? '1' : '0'),
        'loggedIn' => ($this->_user->isLoggedIn() ? '1' : '0'),
        'cookie'  => (defined('COOKIE_NOTICE') ? '1' : '0'),
        'loadingTime' => ((defined('PAGE_LOADING') && PAGE_LOADING == 1) ? PAGE_LOAD_TIME : ''),
        'route' => $route
      );
  
      if (strpos($route, '/forum/topic/') !== false || PAGE == 'profile') {
        $this->addJSFiles(array(
          $this->_template['path'] . 'js/jquery-ui.min.js' => array()
        ));
      }
  
      $JSVars = '';
      $i = 0;
      foreach ($JSVariables as $var => $value) {
        $JSVars .= ($i == 0 ? 'var ' : ', ') . $var . ' = "' . $value . '"';
        $i++;
      }
  
      $this->addJSScript($JSVars);
  
      $this->addJSFiles(array(
        $this->_template['path'] . 'js/core/core.js' => array(),
        $this->_template['path'] . 'js/core/user.js' => array(),
        $this->_template['path'] . 'js/core/pages.js' => array(),
        $this->_template['path'] . 'js/scripts.js' => array(),
      ));
  
      foreach ($this->_pages->getAjaxScripts() as $script)
        $this->addJSScript('$.getJSON(\'' . $script . '\', function(data) {});');
    }
}

$template = new Nexus_Template($cache, $smarty, $language, $user, $pages);
$template_pagination = array('div' => 'ui mini pagination menu', 'a' => '{x}item');
