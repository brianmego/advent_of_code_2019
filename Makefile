build: .build_erlang
	
.build_erlang: $(shell find . -name '*.erl')
	erlc *.erl
	@echo 'Erlang beam files built'
	@touch $@

erlang: .build_erlang
