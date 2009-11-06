package MyApp::Templates::HTML;

use strict;
use warnings;
use parent 'Template::Declare::Catalyst';
use Template::Declare::Tags;
use Sub::Exporter -setup => { exports => [qw(wrapper) ] };

create_wrapper wrapper => sub {
    my ($code, $c, $args) = @_;
    xml_decl { 'xml', version => '1.0' };
    outs_raw '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" '
           . '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">';
    html {
        head {
            title { $args->{title} || 'My Catalyst App!' };
            link {
                rel is 'stylesheet';
                href is $c->uri_for('/static/css/main.css' );
            };

        };

        body {
            div {
                id is 'header';
                # Your logo can go here.
                img {
                    src is $c->uri_for('/static/images/btn_88x31_powered.png');
                };
                # Page title.
                h1 { $args->{title} || $c->config->{name} };
            }; # end header.

            div {
                id is 'bodyblock';
                div {
                    id is 'menu';
                    h3 { 'Navigation' };
                    ul {
                        li {
                            a {
                                href is $c->uri_for('/books/list');
                                'Home';
                            };
                        };
                        li {
                            a {
                                href is $c->uri_for('/');
                                title is 'Catalyst Welcome Page';
                                'Welcome';
                            };
                        };
                    };
                }; # end menu

                div {
                    id is 'content';
                    # Status and error messages.
                    if (my $msg = $args->{status_msg}) {
                        span { class is 'message'; $msg };
                    }
                    if (my $err = $args->{error_msg}) {
                        span { class is 'error'; $err };
                    }

                    # Output the template contents.
                    $code->($args);
                }; # end content

            }; # end bodyblock
        };
    };
};

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

