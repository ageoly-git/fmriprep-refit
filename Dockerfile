FROM dbp2123/afni:0.0.1_20.0.18
FROM bash:4.4
FROM alpine:latest

RUN apk add --no-cache bash \
   python3 \
   py-pip \
   jq \
   zip \
  && pip install flywheel-sdk \
  && rm -rf /var/cache/apk/*

#WORKDIR /tmp
ENV FLYWHEEL=/flywheel/v0
RUN mkdir -p ${FLYWHEEL}


COPY run $FLYWHEEL/run
COPY revise_fmriprep_dir.sh $FLYWHEEL 

RUN chmod +x $FLYWHEEL/run \
             $FLYWHEEL/revise_fmriprep_dir.sh 
          

ENTRYPOINT /bin/bash
#ENTRYPOINT ["/bin/bash"]