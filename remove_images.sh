DIGESTS=$(doctl registry repository lt $1 --format Manifest\ Digest,UpdatedAt | tail -n +2 | sort -rk2 | awk '{print $1}' | tail -n +$(($2+1)))
for DIGEST in $DIGESTS; do
  doctl registry repository delete-manifest $1 $DIGEST --force
done
echo Manifest Digests removed: $DIGESTS