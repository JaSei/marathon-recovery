#!/usr/bin/env perl 
use strict;
use warnings;

use feature qw(say);

use JSON;
use Getopt::Kingpin;
use Mojo::UserAgent;
use Try::Tiny;
use Path::Tiny;

my @fields = qw(id cmd args env instances cpus mem constraints uris backoffSeconds backoffFactor maxLaunchDelaySeconds container healthChecks readinessChecks dependencies upgradeStrategy labels secrets taskKillGracePeriodSeconds unreachableStrategy killSelection);
my %fields_map = map { $_ => 0 } @fields;

my $kingpin = Getopt::Kingpin->new();
my $path = $kingpin->arg('file', 'marathon json file or - for stdin')->required->string();
my $url  = $kingpin->flag('url', 'marathon url endpoint aka http://my-marathon.host.com')->required->string();
$kingpin->parse();

my $json = JSON->new();
my $ua   = Mojo::UserAgent->new();

my $apps = $json->decode(input_json());
foreach my $app ($apps->{apps}->@*) {
    my $new_app;

    my %new_app = map { $_ => $app->{$_} } grep { exists $fields_map{$_} } keys %$app;

    try {
        say $app->{id};
        say $ua->put("$url/v2/apps$app->{id}" => json => \%new_app)->result->body;
    }
    catch {
        say "Problem: $_";
    };
}

sub input_json {
    if ($path->value() eq '-') {
        do { local $/; <STDIN> };
    }
    else {
        path($path)->slurp();
    }
}
