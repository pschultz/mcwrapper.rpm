NAME    := mcwrapper
VERSION := 0.1.3
ARCH    := noarch
OS      := el6

ITERATION    := 1
DESCRIPTION  := [pschultz] Control wrapper for Minecraft servers
MAINTAINER   := Peter Schultz <schultz.peter@hotmail.com>

INSTALL_ROOT := inst_root
PACKAGE      := $(NAME)-$(VERSION)-$(ITERATION).$(OS).$(ARCH).rpm

SCRIPT       := usr/bin/$(NAME)
SCRIPT_SRC   := https://github.com/pschultz/MC-Wrapper/raw/master/bin/mcwrapper.pl

.PHONY: all clean distclean
.NOTPARALLEL:

all: $(PACKAGE)

$(PACKAGE): $(INSTALL_ROOT)/$(SCRIPT)
	fpm -s dir -t rpm -a all -n $(NAME) -p $(PACKAGE) -v $(VERSION) -C "$(INSTALL_ROOT)" \
		--iteration $(ITERATION) \
		--description '$(DESCRIPTION)' \
		--maintainer "$(MAINTAINER)" \
		--exclude '.git*' \
		--exclude '*/.git*' \
		-d perl-Proc-Daemon -d jre \
		usr

$(INSTALL_ROOT)/$(SCRIPT):
	wget $(SCRIPT_SRC) -O $@
	chmod +x $@

clean: 
	rm -f $(PACKAGE)

distclean: clean
	rm -f $(INSTALL_ROOT)/$(SCRIPT)
