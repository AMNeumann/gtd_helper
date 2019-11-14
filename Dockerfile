from alpine:latest

RUN apk update && apk add cmake g++ make git gnutls-dev util-linux-dev python3-dev libffi-dev libressl-dev vim perl-dev perl-app-cpanminus
RUN git clone https://github.com/GothenburgBitFactory/taskwarrior.git /taskwarrior && \
      mkdir /build-taskwarrior && cd /build-taskwarrior && cmake -DCMAKE_BUILD_TYPE=Release /taskwarrior && make && make install
RUN git clone https://github.com/GothenburgBitFactory/taskshell.git /taskshell && \
      cd /taskshell && sed -i 's/git.tasktools.org\/TM/github.com\/GothenburgBitFactory/' .gitmodules && \
      git submodule init && git submodule update && \
      mkdir /build-taskshell && cd /build-taskshell && cmake -DCMAKE_BUILD_TYPE=Release /taskshell && make && make install
RUN git clone https://github.com/GothenburgBitFactory/timewarrior.git /timewarrior && \
      cd /timewarrior && sed -i 's/git.tasktools.org\/TM/github.com\/GothenburgBitFactory/' .gitmodules && \
      git submodule init && git submodule update && \
      mkdir /build-timewarrior && cd /build-timewarrior && cmake -DCMAKE_BUILD_TYPE=Release /timewarrior && make && make install
RUN pip3 install jrnl
RUN cpanm --verbose --no-wget Module::Build Graph::Easy

RUN addgroup -g 236 cc-ilf
RUN adduser -D -u 7183 neumanna cc-ilf

ADD taskrc /home/neumanna/.taskrc
ADD jrnl_config /home/neumanna/.jrnl_config
RUN chown --recursive neumanna:cc-ilf /home/neumanna

USER 7183:236


