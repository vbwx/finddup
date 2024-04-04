use strict;
use warnings;
use 5.018;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => 'finddup',
	AUTHOR => 'Bernhard Waldbrunner <vbwx01@gmail.com>',
	ABSTRACT => 'Finds duplicated files fast and efficiently',
	VERSION_FROM => 'finddup',
	LICENSE => 'mit',
	PREREQ_PM => {
		'Text::Glob' => '0.11',
		'Sort::Key' => '1.33',
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
