import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morti/core/error/failure.dart';
import 'package:rick_and_morti/core/usecases/usecases.dart';
import 'package:rick_and_morti/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morti/feature/domain/repositories/person_repository.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepository;

  SearchPerson(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(SearchPersonParams params) async {
    print(params);
    return await personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;

  SearchPersonParams({required this.query});

  @override
  List<Object> get props => [query];
}