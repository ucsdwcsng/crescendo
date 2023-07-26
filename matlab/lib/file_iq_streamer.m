classdef file_iq_streamer < handle
    %FILE_IQ_STREAMER Class to extract samples from a large file
    %   This class was created to get samples in small bursts from a 
    % large IQ sample file.
    
    properties
        file_name
        current_sample_offset
        eof_flag
        sample_buffer
        overlapN
        sample_read_fn
    end
    
    methods
        function obj = file_iq_streamer(file_name,start_offset,overlapN,sample_read_fn)
            %FILE_IQ_STREAMER Construct an instance of this class
            %   :input: file_name  : string containing filename to stream
            %   :input: start_offset  : integer for initial offset (optional)
            %   :input: overlapN : number of samples for overlap between
            %   consecutive read windows (optional). -ve number here causes
            %   samples to be skipped after every read.
            %
            obj.file_name = file_name;
            switch nargin
                case 1
                    obj.current_sample_offset = 0;
                    obj.overlapN = 0;
                    obj.sample_read_fn = @read_complex_binary;
                case 2
                    obj.current_sample_offset = start_offset;
                    obj.overlapN = 0;
                    obj.sample_read_fn = @read_complex_binary;
                case 3
                    obj.current_sample_offset = start_offset;
                    obj.overlapN = overlapN; 
                    obj.sample_read_fn = @read_complex_binary;
                case 4
                    obj.current_sample_offset = start_offset;
                    obj.overlapN = overlapN; 
                    obj.sample_read_fn = sample_read_fn;
            end
            obj.sample_buffer = [];
            obj.eof_flag = 0;
           
        end
        
        function [sample_buffer] = read_n_samples(obj,N)
            %read_n_samples Read N samples into the buffer
            % :input: N : natural number for number of samples to read
            % reads N samples to obj.sample_buffer
            % NOTE: erases existing contents of buffer
            assert(obj.eof_flag==0,"End of file reached!");
            
            try
                sample_buffer = obj.sample_read_fn(obj.file_name,N,obj.current_sample_offset);
                obj.current_sample_offset = obj.current_sample_offset + N - obj.overlapN;
            catch
                sample_buffer = [];
            end
            
            obj.sample_buffer = sample_buffer;
            
            switch numel(obj.sample_buffer)                
                case 0
                    error("End of file reached, or read error")
                case N
                    1 + 1; % do nothing
                otherwise
                    obj.eof_flag = 1;
            end
        end
        
        function obj = reset_read_header(obj)
           %reset_read_header Reset sample offset and eof flag
           obj.eof_flag = 0;
           obj.current_sample_offset = 0;            
        end
        
    end
end

