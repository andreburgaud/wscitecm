#---------------------------------------------------------------------------
# See LICSENSE
#---------------------------------------------------------------------------
# abpack.pl: Generates binaries and sources archives
#---------------------------------------------------------------------------

require "ctime.pl";
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );

my $author_name = "Andre Burgaud";
my $author_email = "andre\@burgaud.com";
my $author_web = "www.burgaud.com";

my $project_title = "Context Menu Extension for SciTE";
my $project_name = "wscitecm";
my $project_extension = "140";
my $project_version = "1.4.0";
my $project_date = "12/06/2008";

my $note_line = "================================\n";

my @list_bin = qw(
  readme.txt
  license.txt
  wscitecm-remove.reg
  wscitecm.dll
  wscitecm64.dll
);

my @list_src = qw(
  readme.txt
  license.txt
  wscitecm-remove.reg
  wscitecm.cpp
  wscitecm.h
  wscitecm.rc
  wscitecm.def
  resource.h
  scite.bmp
  Makefile
  abpack.pl
);

# Binaries Package
my $note_bin = create_note("Binary Files");
my $zip_bin = Archive::Zip->new();
print "Creating binary package...\n";
create_zip("$project_name$project_extension.zip", $zip_bin, $note_bin, @list_bin);

# Sources Package
my $note_src = create_note("Source Files");
my $zip_src = Archive::Zip->new();
print "Creating source package...\n";
create_zip("$project_name$project_extension" . "_src.zip", $zip_src, $note_src, @list_src);

# Functions
sub create_zip(zip_name, comment, zip, list) {
  my ($zip_name, $zip, $comment, @list) = @_;
  for (@list) {
    print "Zipping $_...\n";
    $member = $zip->addFile($_);
  }
  $member->desiredCompressionLevel(9);
  $zip->zipfileComment($comment);
  die "Write error" if $zip->writeToFileNamed($zip_name) != AZ_OK;
}

sub create_note() {
  my ($type) = @_;
  my $note = "";
  $note .= $note_line;
  $note .= "$project_title\n";
  $note .= $note_line;
  $note .= "$type\n";
  $note .= "Version: $project_version $project_date\n";
  $note .= "Author: $author_name <$author_email>\n";
  $date=&ctime(time);
  $note .= "$date";
  return $note;
}