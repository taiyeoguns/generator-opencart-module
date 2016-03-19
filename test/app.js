'use strict';
var path = require('path');
var assert = require('yeoman-assert');
var helpers = require('yeoman-generator').test;

describe('generator-opencart-module', function () {
  before(function (done) {
    helpers.run(path.join(__dirname, '../generators/app'))
		.withPrompts(
			{
				module_name: 'a module', 
				module_type: 'module', 
				version: '2_x', 
				vqmod: true
			}
		)
    .on('end', done);
  });

  /*
   * Admin
  */
  
  //controller
  it('creates admin controller', function () {
    assert.file([
      'upload/admin/controller/module/a_module.php'
    ]);
    assert.fileContent('upload/admin/controller/module/a_module.php', 'class ControllerModuleAModule extends Controller {');
  });
  
  //language
  it('creates admin language', function () {
    assert.file([
      'upload/admin/language/english/module/a_module.php'
    ]);
  });
  
  //view
  it('creates admin view', function () {
    assert.file([
      'upload/admin/view/template/module/a_module.tpl'
    ]);
  });

  /*
   * Catalog
  */
  
  //controller
  it('creates catalog controller', function () {
    assert.file([
      'upload/catalog/controller/module/a_module.php'
    ]);
    assert.fileContent('upload/catalog/controller/module/a_module.php', 'class ControllerModuleAModule extends Controller {');
  });
  
  //language
  it('creates catalog language', function () {
    assert.file([
      'upload/catalog/language/english/module/a_module.php'
    ]);
  });
  
  //view
  it('creates catalog view', function () {
    assert.file([
      'upload/catalog/view/theme/default/template/module/a_module.tpl'
    ]);
  });

  /*
   * vQmod
  */
  
  it('creates vqmod', function () {
    assert.file([
      'upload/vqmod/xml/a_module.xml'
    ]);
  });
});
