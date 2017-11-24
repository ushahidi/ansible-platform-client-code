def test_index_html(File):
	assert File('/var/www/platform-client/index.html').exists
