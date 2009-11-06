package MyApp::Templates::HTML;

use strict;
use warnings;
use parent 'Template::Declare::Catalyst';
use Template::Declare::Tags;

# See Template::Declare docs for details on creating templates, which look
# something like this.
# template hello => sub {
#     my ($self, $vars) = @_;
#     html {
#         head { title { "Hello, $vars->{user}" } };
#         body { h1    { "Hello, $vars->{user}" } };
#     };
# };

=head1 NAME

MyApp::Templates::HTML - HTML templates for MyApp

=head1 DESCRIPTION

HTML templates for MyApp.

=head1 SEE ALSO

=over

=item L<Template::Declare>

=item L<MyApp::View::HTML>

=item L<MyApp>

=item L<Catalyst::View::TD>

=back

=head1 AUTHOR

David E. Wheeler

=head1 LICENSE

This library is free software. You can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;

