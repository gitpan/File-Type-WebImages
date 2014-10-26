#!/usr/bin/perl -w
use strict;

use lib './lib','../lib';

use File::Type::WebImages;
use Test::More;

=for testing

Set up a list of files to test.

=cut

my $types = {
  "files/blank.jpg" => "image/jpeg",
  "files/blank.png" => "image/png",
  "files/blank.gif"  => "image/gif",
  "files/blank.bmp"  => "image/bmp",
};

plan tests => 2 * scalar keys %{ $types };

=for testing

Initialise the object.

=cut

=for testing

Loop over the objects, testing each both ways.

=cut

foreach my $filename (sort keys %$types) {
  my $mimetype = $types->{$filename};
  is(File::Type::WebImages::checktype_filename("t/$filename"), $mimetype, "check file $filename");
  my $data = read_file("t/$filename") || die;
  is(File::Type::WebImages::checktype_contents($data), $mimetype, "check data $filename");
}

sub read_file {
  my $file = shift;

  local $/ = undef;
  open FILE, $file or die "Can't open file $file: $!";
  my $data = <FILE>;
  close FILE;
  
  return $data;
}
