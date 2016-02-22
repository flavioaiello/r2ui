'use strict';

/**
 * @ngdoc function
 * @name r2ui.controller:RepositoriesCtrl
 * @description
 * # RepositoriesCtrl
 * Controller of the r2ui
 */
angular.module('r2ui')
  .controller('RepositoriesCtrl', function ($state, $mdToast, dockerRegistry) {
    var scope = this;

    scope.openRepository = function openRepository(repository) {
      $state.go('main.repository', { name: repository });
    };

    dockerRegistry.getRepositories()
      .then(function (repositories) {
        scope.repositories = repositories;
      })
      .catch(function (err) {
        $mdToast.show(
            $mdToast.simple()
              .content('Failed getting repositories: ' + err.statusText)
              .position('top right')
              .hideDelay(3000)
        );
      });
  });
