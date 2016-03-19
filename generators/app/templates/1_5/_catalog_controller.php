<?php

class Controller<%= classified_name %> extends Controller {
	
	protected function index() {
		
		//Load language file
		$this->language->load('<%= module_type %>/<%= underscored_name %>');

		//Set title from language file
      	$this->data['heading_title'] = $this->language->get('heading_title');

		//Load model
		$this->load->model('<%= module_type %>/<%= underscored_name %>');

		//Sample - get data from loaded model
		$this->data['customers'] = $this->model_<%= module_type %>_<%= underscored_name %>->getCustomerData();

		//Select template
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/<%= module_type %>/<%= underscored_name %>.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/<%= module_type %>/<%= underscored_name %>.tpl';
		} else {
			$this->template = 'default/template/<%= module_type %>/<%= underscored_name %>.tpl';
		}

		//Render page
		$this->render();
	}
	
}
?>