#docker run -it zjb0807/v8 bash
#https://chromium.googlesource.com/chromium/src/+/lkcr/docs/mac_build_instructions.md
#https://github.com/v8/v8/wiki/Getting-Started-with-Embedding

FROM ubuntu:16.04

ENV V8_VERSION 6.2.414.40

RUN apt-get update && \
    apt-get -y install git curl wget \
               g++ binutils python \
               make gcc \
               bzip2 xz-utils \
               pkg-config

WORKDIR /root

# install depot_tools
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools
ENV PATH $PATH:/root/depot_tools

# install v8
RUN fetch --nohooks v8 && \
    cd v8 && \
    git checkout $V8_VERSION && \
    gclient sync && \
    #tools/dev/v8gen.py x64.release  && \
    gn gen out.gn/x64.release --args="is_debug=false target_cpu=\"x64\" is_component_build=true v8_static_library=true use_custom_libcxx=false use_custom_libcxx_for_host=false" && \
    ninja -C out.gn/x64.release


# /root/v8/include
# /root/v8/out.gn/x64.release/snapshot_blob.bin
# /root/v8/out.gn/x64.release/natives_blob.bin
