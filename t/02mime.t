#!/usr/bin/perl -w
use strict;

use lib './lib','../lib';

use File::Type::WebImages 'mime_type';
use Test::More;

my $types = {
  "files/blank.jpg" => "image/jpeg",
  "files/blank.png" => "image/png",
  "files/blank.gif"  => "image/gif",
};

plan tests => scalar keys %{ $types };

=for testing

Loop over the objects, testing each both ways.

=cut

foreach my $filename (sort keys %{ $types }) {
  my $mimetype = $types->{$filename};
  my $argument = $filename;
  my $checktype;

  # randomly read in file, or make filename correct
  if (rand > 0.5) {
    $argument = read_file("t/$filename") || die;
    $checktype = 'data';
  } else {
    $argument = "t/".$argument;
    $checktype = 'file';
  }

  is(mime_type($argument), $mimetype, "magically checked $checktype");
}

sub read_file {
  my $file = shift;

  local $/ = undef;
  open FILE, $file or die "Can't open file $file: $!";
  my $data = <FILE>;
  close FILE;
  
  return $data;
}
