requires 'Text::Glob', '0.11';
requires 'Sort::Key', '1.33';

on 'develop' => sub {
	requires 'Pod::Markdown', '3.400';
	recommends 'Perl::Critic';
	suggests 'B::Lint';
};
