package MyApp::View::HTML;

use strict;
use warnings;
use parent 'Catalyst::View::TD';

# Unless auto_alias is false, Catalyst::View::TD will automatically load all
# modules below the MyApp::Templates::HTML namespace and alias their
# templates into MyApp::Templates::HTML. It's simplest to create your
# template classes there. See the Template::Declare documentation for a
# complete description of its init() parameters, all of which are supported
# here.

__PACKAGE__->config(
    # dispatch_to     => [qw(MyApp::Templates::HTML)],
    # auto_alias      => 1,
    # strict          => 1,
    # postprocessor   => sub { ... },
    # around_template => sub { ... },
);

=head1 NAME

MyApp::View::HTML - HTML View for MyApp

=head1 DESCRIPTION

TD View for MyApp. Templates are written in the
MyApp::Templates::HTML namespace.

=head1 SEE ALSO

L<MyApp>

=head1 AUTHOR

David E. Wheeler

=head1 LICENSE

This library is free software. You can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
