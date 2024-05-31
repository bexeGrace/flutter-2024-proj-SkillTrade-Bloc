import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/infrastructure/data_sources/individual_technician_remote_data_source.dart';

class IndividualTechnicianRepository {
  final IndividualTechnicianRemoteDataSource remoteDataSource;

  IndividualTechnicianRepository({required this.remoteDataSource});

  Future<Technician> getIndividualTechnician(String technicianId) async {
    return await remoteDataSource.fetchIndividualTechnician(technicianId);
  }

  Future<void> updateTechnicianProfile(String technicianId, Map<String, dynamic> updates) async {
    await remoteDataSource.updateTechnicianProfile(technicianId, updates);
  }

  Future<void> updatePassword(Map<String, dynamic> updates) async {
    await remoteDataSource.updatePassword(updates);
  }
}
