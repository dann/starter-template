use inc::Module::Install;

name           'App-Package-Starter';
requires 'File::Spec'               => 0;
requires 'File::Basename'           => 0;
requires 'File::Find'               => 0;
requires 'Pod::Usage'               => 0;
requires 'File::Path'               => 0;

WriteAll;

