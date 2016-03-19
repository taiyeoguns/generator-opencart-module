<?php

class Controller<%= classified_name %> extends Controller {
	
	private $error = array(); 
	
	public function index() {   
		//Load language file
		$this->load->language('<%= module_type %>/<%= underscored_name %>');

		//Set title from language file
		$this->document->setTitle($this->language->get('heading_title'));
		
		//Load settings model
		$this->load->model('setting/setting');
		
		//Save settings
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('<%= underscored_name %>', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/<%= module_type %>', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$text_strings = array(
				'heading_title',
				'button_save',
				'button_cancel',
				'button_add_module',
				'button_remove',
				'placeholder',
		);
		
		foreach ($text_strings as $text) {
			$this->data[$text] = $this->language->get($text);
		}
			
		//error handling
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_<%= module_type %>'),
			'href'      => $this->url->link('extension/<%= module_type %>', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('<%= module_type %>/<%= underscored_name %>', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('<%= module_type %>/<%= underscored_name %>', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/<%= module_type %>', 'token=' . $this->session->data['token'], 'SSL');

	
		//Check if multiple instances of this module
		$this->data['modules'] = array();
		
		if (isset($this->request->post['<%= underscored_name %>_module'])) {
			$this->data['modules'] = $this->request->post['<%= underscored_name %>_module'];
		} elseif ($this->config->get('<%= underscored_name %>_module')) { 
			$this->data['modules'] = $this->config->get('<%= underscored_name %>_module');
		}		

		//Prepare for display
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		
		$this->template = '<%= module_type %>/<%= underscored_name %>.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		//Send the output.
		$this->response->setOutput($this->render());
	}
	
	/*
	 * 
	 * Check that user actions are authorized
	 * 
	 */
	private function validate() {
		if (!$this->user->hasPermission('modify', '<%= module_type %>/<%= underscored_name %>')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}


}
?>