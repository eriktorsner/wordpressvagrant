module.exports = function(grunt) {
	var shell = require('shelljs');

	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
	});

	
	grunt.registerTask('default', 'Log some stuff.', function() {
		ls = getLocalsettings();
		devdns = process.env.DEVDNS;
		grunt.log.write('Hear hear, we are up... DNS name for this machine:' + devdns).ok();
	});



	/*
	* Installing WP
	*/
	grunt.registerTask('wp-install', '', function() {
		ls = getLocalsettings();
		wpcmd = 'wp --path=' + ls.wppath + ' --allow-root ';

		shell.mkdir('-p', ls.wppath);

		if(!shell.test('-e', ls.wppath + '/wp-config.php')) {
			shell.exec(wpcmd + 'core download --force');
			shell.exec(wpcmd + 'core config --dbname=' + ls.dbname + ' --dbuser=' + ls.dbuser + ' --dbpass=' + ls.dbpass + ' --quiet');
			shell.exec(wpcmd + 'core install --url=' + ls.url + ' --title="WordPress App" --admin_name=' + ls.wpuser + ' --admin_email="admin@local.dev" --admin_password="' + ls.wppass + '"');
		} else {
			grunt.log.write('Wordpress is already installed').ok();
		}
	});


	function getLocalsettings(test) {
		var testMode = grunt.option('test');
		if(test == true) {
			testMode = true;
		}
		ls = grunt.file.readJSON('localsettings.json');
		if(ls.wppath === undefined) ls.wppath = shell.pwd() + '/www/wordpress-default';
		if(testMode == true) {
			ls.environment = 'test';
			ls.wppath = ls.wppath_test;
			ls.dbname = ls.dbname_test;
			ls.url = ls.url_test;
		}
		return ls;
	}


};
