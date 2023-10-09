#!/bin/bash -e

# Add preview banner to MOTD
cat >> /etc/motd << EOF
*******************************************************
**            This VM was built from the:            **
**      !! AZURE VM IMAGE BUILDER Custom Image !!    **
**                    for                            **
**       LARUS TECHNOLOGIES CORPORATION, OTTAWA      **
**            Administrator: Nelson Nwajie           **
*******************************************************

*******************************************************
@@               Ubuntu:2204(Latest)                 @@
*******************************************************

EOF
