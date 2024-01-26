use strict;
use warnings;
use v5.16;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => 'finddup',
	AUTHOR => 'Bernhard Waldbrunner <vbwx01@gmail.com>',
	VERSION_FROM => 'finddup',
	ABSTRACT_FROM => 'finddup',
	LICENSE => 'mit',
	PREREQ_PM => {
		'Text::Glob' => '0.11',
		'File::Find' => '1.39',
		'Getopt::Std' => '1.13',
		'File::Spec' => '3.84',
		'File::Compare' => '1.1007',
		'Sort::Key' => '1.33',
		'Pod::Usage' => '1.69',
	},
	BUILD_REQUIRES => {
		'Pod::Man' => '0',
		'Pod::Markdown' => '0',
		'Perl::Critic' => '0',
	},
	EXE_FILES => ['finddup'],
	META_MERGE => {
		'meta-spec' => {version => 2},
		resources => {
			repository => {
				type => 'git',
				url => 'https://github.com/vbwx/finddup.git',
				web => 'https://github.com/vbwx/finddup'
			},
			bugtracker => {web => 'https://github.com/vbwx/finddup/issues'},
			homepage => 'https://vbwx.github.io/finddup'
		}
	}
);

sub MY::postamble {
	local $/;
	my $mk = '';
	for (qw(lint.mk manual.mk)) {
		open(my $f, '<:unix', "include/$_");
		$mk .= <$f>;
		close $f;
	}
	return $mk;
}
