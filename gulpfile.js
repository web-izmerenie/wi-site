'use strict'
var gulp = require('gulp');
var jade = require('gulp-jade');

var tplPath = './';

gulp.task('jade', function () {
	gulp.src(tplPath + '/templates/**/*.jade')
		.pipe(jade({
			pretty: true,
			locals: {
				staticUrl: function(item){
					return '/static/'+item;
				},
				menu: {
					main: require('./static/main-menu.json').ru
				},
				formData: {
					name: ""
				},
				lang: "ru",
				htmlClasses: ["general-page"],
				pageTitle: "Web-izmerenie"
			}
		}))
		.pipe(gulp.dest('./html/'));
});

gulp.task('default', ['jade']);
