'use strict';

/**
 * @ngdoc function
 * @name r2ui.controller:RepositoryCtrl
 * @description
 * # RepositoryCtrl
 * Controller of the r2ui
 */
angular.module('r2ui')
  .controller('RepositoryCtrl', function ($stateParams, $q, dockerRegistry) {
    var scope = this;
    scope.name = $stateParams.name;
    scope.registryBase = dockerRegistry.getRegistryBase();

    dockerRegistry.getTags($stateParams.name)
      .then(function (tags) {
        scope.tags = tags.map(function (tag) {
          return { name: tag };
        });

        // Fetch the manifest for each tag.
        return $q.all(tags.map(function (tag) {
          return dockerRegistry.getManifest($stateParams.name, tag);
        }));
      })
      .then(function (manifests) {
        scope.tags.forEach(function (tag, index) {
          tag.manifest = manifests[index];
        });
      });
  });
