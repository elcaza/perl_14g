#!/usr/bin/perl -w
use LWP::UserAgent ();

# User Agent
$user_agent = new LWP::UserAgent;
$user_agent->agent("jmartinez");

# Petición
$resp = $user_agent->get('http://164.90.148.203:7745/ZmxhZy50eHQ=');
($resp->is_success) ? print $resp->content : die $response->status_line ;